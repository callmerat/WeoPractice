package com.system.blog;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/common")
public class FileUploadController {

	private String dir = "C:\\Users\\osymi\\git\\springmvc-smarteditor2\\src\\main\\webapp\\blog\\";
	
	
	@PostMapping("/upload-file")
    public @ResponseBody String uploadFile(MultipartFile Filedata, @RequestParam Map<String, Object> params, @RequestParam(defaultValue = "upload") String folder) throws IOException {
    	

        String sFileInfo = "";
        String brandstoryPath =  folder + "/";

        String yyyyMM = new SimpleDateFormat("yyyyMM").format(new Date());

        String fileName = UUID.randomUUID().toString().replaceAll("-","");
        String originalFilename = Filedata.getOriginalFilename();
        String filenameExtension = StringUtils.getFilenameExtension(originalFilename);

		String file = fileName + "." + filenameExtension;

        String pathNm = String.format("/%s/%s/%s/%s.%s", "blog", folder, yyyyMM, fileName, filenameExtension);


    	File f = new File(dir, folder + "/" +  yyyyMM);
    	if (!f.exists()) {
    		f.mkdirs();
    	}


		Filedata.transferTo(new File(dir + folder + "/" + yyyyMM, file));

        sFileInfo += "&bNewLine=true";
        sFileInfo += "&sFileName="+file;
        sFileInfo += "&sFileURL="+ pathNm;

		return sFileInfo;
    }
    
    
    @PostMapping("/upload-base64")
    public @ResponseBody String pastBase64(String img,  @RequestParam(defaultValue = "upload") String folder) {
    	
    	String path =  folder + "/";
    	String fileBase64 = img;
    	String sFileInfo = "";
    	
    	Base64.Decoder decoder = Base64.getDecoder();
    	byte[] decodedBytes = decoder.decode(fileBase64.getBytes());
    	
    	String yyyyMM = new SimpleDateFormat("yyyyMM").format(new Date());
    	
    	File f = new File(dir, path + yyyyMM);
    	if (!f.exists()) {
    		f.mkdirs();
    	}
    	String fileName = UUID.randomUUID().toString().replaceAll("-","");
    	
    	try {
			File tempFile = new File(dir + path + yyyyMM, fileName+".png");
			FileOutputStream fileOutputStream = new FileOutputStream(tempFile);
			fileOutputStream.write(decodedBytes);
			fileOutputStream.close();
			
			fileName = tempFile.getName();
			String pathNm = String.format("/%s/%s/%s/%s", "blog", folder, yyyyMM, fileName);
    	

	        sFileInfo = "{\"result\":1, \"filePath\":\"" + pathNm +"\"}";
	        
		} catch (IOException e) {
			e.printStackTrace();
		}
        
    	return sFileInfo;
    }
}
