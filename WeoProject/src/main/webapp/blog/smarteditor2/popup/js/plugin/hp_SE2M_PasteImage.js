/**
 * @use 이미지 붙여넣기 업로드용으로 제작되었습니다.
 * @author kslee
 * @See nhn.husky.SE2M_PasteImage 
 */
nhn.husky.SE2M_PasteImage = jindo.$Class({
	name: "SE2M_PasteImage",

	$init: function () { },

	//$ON_MSG_APP_READY: function () {
	//	this.oApp.exec("REGISTER_UI_EVENT", ["photo_attach", "click", "EVENT_EDITING_AREA_PASTE"]);
	//},
	callAjax: function (tempFile, imgBase64, sUploadURL) {
		var oApp = this.oApp;

		var oAjax = jindo.$Ajax(sUploadURL, {
			type: 'xhr',
			method: "post",
			async: false,
			onload: function (res) { // 요청이 완료되면 실행될 콜백 함수
				if (res.readyState() == 4) {
					var result = JSON.parse(res._response.responseText);
					if (!result.result) {
						alert(result.message);
						return;
					}
					var img = document.createElement("IMG");
					img.src = result.filePath;
					// 업로드된 이미지 추가
					oApp.exec("PASTE_HTML", [img.outerHTML]);
					debugger
				}
			},
			timeout: 3,
			onerror: function (a) {
				console.log(a);
			}
		});
		
		var folder = document.querySelector('[name="folder"]').value;
		debugger
		
		//oAjax.header("Content-Type", "multipart/form-data");
		oAjax.header("file-name", encodeURIComponent(tempFile.name));
		oAjax.header("file-size", tempFile.size);
		oAjax.header("file-Type", tempFile.type);
		oAjax.request({ img: imgBase64, folder: folder });
		return oAjax;
	},
	pasteImage: function (file) {
		var obj = this;
		var reader = new FileReader();
		reader.addEventListener("load", function () {
			var base64 = reader.result.replace('data:image/png;base64,', '');
			try {
				if (!!base64) {
					//Ajax통신하는 부분. 파일과 업로더할 url을 전달한다.
					obj.callAjax(file, base64, '/common/upload-base64');
				}
			} catch (e) { console.log(e); }
		});
		reader.readAsDataURL(file);
	},
	/**
	 * paste 이벤트에서 이미지파일이 있으면 삽입
	 */
	$ON_EVENT_EDITING_AREA_PASTE: function (we) {
		// 크롬이 아닌 경우는 skip
		//if (!jindo.$Agent().navigator().chrome) {
		//	return;
		//}
		
		//we._event.preventDefault();
		
		console.log(we);
		var clipboard = we.$value().clipboardData || {};
		var files = clipboard.files;
		if (!files) {
			return;
		}
		for (var i = 0, len = files.length; i < len; i++) {
			var file = files[i];
			if (file.type.indexOf("image/") === 0) {
			    we._event.preventDefault();
				this.pasteImage(file);
			}
		}
	}
});