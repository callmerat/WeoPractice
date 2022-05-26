<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div id="test">
      <div>{{message}}</div>
      <h1>{{description}}</h1>
    </div>
	
	<div id="test2">
      <div>{{message}}</div>
      <h1>{{description}}</h1>
    </div>

	<!-- vue.js를 사용하려면 다음의 코드를 작성해야 한다. -->
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

	<!-- 기본 형태는 Vue 인스턴스를 생성하여 내부에 el 속성과 data 속성을 넣는 것이다. 아래와 같이 넣으면 된다.
	
	el 속성은 어떠한 id를 가진 html 태그에 종속될 것인지를 표기하는 것이다.
	이를테면 위의 소스에서는 #app이 사용되었으니, <div id="app"></div>에 위의 Vue 인스턴스는 종속될 수 있다.

	Vue 인스턴스가 없었다면, <div>태그 내부에 {{message}}가 적혀져 나왔겠지만, 
	스크립트 내부에 Vue 인스턴스가 있기 때문에 Vue 인스턴스 내부에 있는 message 속성의 값을 화면으로 가져왔다.
	
	 -->
	<script>
	
		var app1 = new Vue({
			el : '#test',
			data : {
				message : '메시지1',
				description : '안녕하세요?',
			},
		});
		
		var app2 = new Vue({
			el : '#test2',
			data : {
				message : '메시지2',
				description : '반갑습니다!',
			},
		});

	</script>
	
</body>
</html>