package com.system.blog;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import net.sf.jxls.transformer.XLSTransformer;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.Resource;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class ExcelUtils {

    private static final Logger logger = LoggerFactory.getLogger(ExcelUtils.class);

    public static void downloadExcel(HttpServletRequest request, HttpServletResponse response, Map beans, Resource templateFileName, String downloadFileName) throws Exception {

        InputStream is = templateFileName.getInputStream();
//        InputStream is = new FileInputStream(templateFileName.getFile().toPath().toString());

        XLSTransformer transformer = new XLSTransformer();
        Workbook workbook = transformer.transformXLS(is, beans);

        response.setHeader("Content-Transfer-Encoding", "binary;");
        response.setHeader("Pragma", "no-cache;");
        response.setHeader("Expires", "-1;");
        response.setHeader("Content-Disposition", "attachment;filename=\""+ java.net.URLEncoder.encode(downloadFileName, "UTF-8") + "\";");

        workbook.write(response.getOutputStream());
    }


    /**
     * 엑셀데이터(파일)를 리스트 데이터로 반환
     * @throws Exception
     */
    public static List<EgovMap> xlsx_excelFileUpload(MultipartFile file, List<String> colNames) throws IOException {
        List<EgovMap> list = new ArrayList<EgovMap>();
        Workbook wb = null;

        // 시작 행 설정
        int startRow = 1;

        // 시작 컬럼 설정
        int startCell = 0;
        try {
            wb = WorkbookFactory.create(file.getInputStream());
        } catch (IOException | InvalidFormatException e) {
            logger.error("엑셀파일 로딩 실패" + e);
        }

        if (wb != null && wb.getSheetAt(0) != null) {
            Sheet sheet = wb.getSheetAt(0);

            int rowCnt = sheet.getPhysicalNumberOfRows();
            int colCnt = colNames.size();

            if (startRow > rowCnt) {
                logger.error("엑셀파일 로딩 실패  startRow > rowCnt");
            }

            for (int rowIdx = startRow; rowIdx < rowCnt; rowIdx++) {
                // 행을 읽다
                Row xRow = sheet.getRow(rowIdx);
                if (xRow != null) {
                    // 셀의 수
                    int cellCnt = xRow.getPhysicalNumberOfCells();
                    int notEmptyCnt = 0;
                    EgovMap rowData = new EgovMap();
                    for (int colIdx = 0, cellIdx = startCell; colIdx < colCnt; colIdx++, cellIdx++) {

                        Object value = "";
                        if (cellCnt > (cellIdx)) {
                            // 셀값 읽기
                            Cell xCell = xRow.getCell(cellIdx);
                            if (xCell != null) {
                                // 타입별로 내용 읽기
                                switch (xCell.getCellType()) {

                                    case Cell.CELL_TYPE_BLANK:
                                        value = "";
                                        break;
                                    case Cell.CELL_TYPE_BOOLEAN:
                                        value = xCell.getBooleanCellValue();
                                        break;
                                    case Cell.CELL_TYPE_ERROR:
                                        value = xCell.getErrorCellValue();
                                        break;
                                    case Cell.CELL_TYPE_FORMULA:
                                        value = xCell.getCellFormula();
                                        break;
                                    case Cell.CELL_TYPE_NUMERIC:
                                        if(DateUtil.isCellDateFormatted(xCell)) {
                                            Date dateCellValue = xCell.getDateCellValue();
                                            value = new SimpleDateFormat("yyyy-MM-dd").format(dateCellValue);
                                        } else {
                                            xCell.setCellType(Cell.CELL_TYPE_STRING);
                                            value = xCell.getStringCellValue();
                                        }
                                        break;
                                    case Cell.CELL_TYPE_STRING:
                                        value = xCell.getStringCellValue();
                                        break;
                                    default:
                                        // for inspection
                                }
                            }
                        }
                        rowData.put(colNames.get(colIdx), value);
                        if (value != null
                                && StringUtils.hasLength(value.toString()) ) {
                            notEmptyCnt++; // 빈값이 아닌것
                        }
                    }
                    if (!rowData.isEmpty() && notEmptyCnt > 0) { // 빈로우 추가 안함
                        list.add(rowData);
                    }
                }
            }

        } else {
            logger.debug("엑셀파일 로딩 실패");
        }

        return list;
    }
}
