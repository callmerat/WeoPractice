<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div id="app-1">
		<div>{{message}}</div>
		<div>{{description}}</div>
	</div>

	<hr>

	<div id="app-2">
		<span v-bind:title="message"> app2.message = ""</span>
	</div>

	<hr>

	<div id="app-3">
		<p v-if="seen">app3.seen=false</p>
	</div>

	<hr>

	<div id="app-4">
		app4.todos.push({ text: 'New item' })
		<ol>
			<li v-for="todo in todos">{{ todo.text }}</li>
		</ol>
	</div>

	<hr>

	<div id="app-5">
		<p>{{ message }}</p>
		<button v-on:click="reverseMessage">메시지 뒤집기</button>
	</div>

	<hr>

	<div id="app-6">
		<p>{{ message }}</p>
		<input v-model="message">
	</div>

	<hr>

	<div id="app-7">
		app7.groceryList.push({ text:'New item'})
		<ol>
		<!--

	      이제 각 todo-item 에 todo 객체를 제공합니다.
	      화면에 나오므로, 각 항목의 컨텐츠는 동적으로 바뀔 수 있습니다.
	      또한 각 구성 요소에 "키"를 제공해야합니다 (나중에 설명 됨).
	      
	     -->
			<todo-item 
			v-for="item in groceryList" 
			v-bind:todo="item"
			v-bind:key="item.id"
			></todo-item>
		</ol>
	</div>

	<hr>

	<div id="app-8">
	  <p>{{ foo }}</p>
	  <!-- 버튼을 누르면 'baz'로 변하도록 코딩하였으나, 스크립트의 Object.freeze(obj) 문장으로 인해 변하지 않음 -->
	  <!-- obj.foo는 더이상 변하지 않습니다! -->
	  <button v-on:click="foo = 'baz'">Change it</button>
	</div>

	<hr>
	
	<div id="app-9">
	<span v-once>{{ message }}</span>
	</div>
	
	<hr>
	
	<!-- vue.js를 사용하려면 다음의 코드를 작성해야 한다. -->
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

	<!-- 
	
	app-1
	
	기본 형태는 Vue 인스턴스를 생성하여 내부에 el 속성과 data 속성을 넣는 것이다. 아래와 같이 넣으면 된다.
	
	el 속성은 어떠한 id를 가진 html 태그에 종속될 것인지를 표기하는 것이다.
	이를테면 위의 소스에서는 #app이 사용되었으니, <div id="app"></div>에 위의 Vue 인스턴스는 종속될 수 있다.

	Vue 인스턴스가 없었다면, <div>태그 내부에 {{message}}가 적혀져 나왔겠지만, 
	스크립트 내부에 Vue 인스턴스가 있기 때문에 Vue 인스턴스 내부에 있는 message 속성의 값을 화면으로 가져왔다.
	
	-->


	<script>
		var app1 = new Vue({
			el : '#app-1',
			data : {
				message : 'app1.message=""',
				description : 'app1.description=""',
			},
		});

		//-----------------------------------------------------------------
		// v-bind 속성은 디렉티브 이라고 합니다. 
		// 디렉티브는 Vue에서 제공하는 특수 속성임을 나타내는 v- 접두어가 붙어있으며 사용자가 짐작할 수 있듯 
		// 렌더링 된 DOM에 특수한 반응형 동작을 합니다. 기본적으로 “이 요소의 title 속성을 Vue 인스턴스의 message 속성으로 최신 상태를 유지합니다. 
	 
		var app2 = new Vue({
			el : '#app-2',
			data : {
				message : '이 페이지는 ' + new Date() + ' 에 로드 되었습니다'
			}
		})

		//-----------------------------------------------------------------
		// 이 예제는 텍스트와 속성뿐 아니라 DOM의 구조에도 데이터를 바인딩 할 수 있음을 보여줍니다. 
		// 또한 Vue 엘리먼트가 Vue에 삽입/업데이트/제거될 때 자동으로 트랜지션 효과를 적용할 수 있는 강력한 전환 효과 시스템을 제공합니다.
	
		var app3 = new Vue({
			el : '#app-3',
			data : {
				seen : true
			}
		})

		//-----------------------------------------------------------------

		var app4 = new Vue({
			el : '#app-4',
			data : {
				todos : [ {
					text : 'JavaScript 배우기'
				}, {
					text : 'Vue 배우기'
				}, {
					text : '무언가 멋진 것을 만들기'
				} ]
			}
		})

		//-----------------------------------------------------------------

		var app5 = new Vue({
			el : '#app-5',
			data : {
				message : '안녕하세요! Vue.js!'
			},
			methods : {
				reverseMessage : function() {
					this.message = this.message.split('').reverse().join('')
				}
			}
		})

		//-----------------------------------------------------------------

		var app6 = new Vue({
			el : '#app-6',
			data : {
				message : '안녕하세요 Vue!'
			}
		})

		//-----------------------------------------------------------------
		// Vue에서 컴포넌트는 미리 정의된 옵션을 가진 Vue 인스턴스 입니다. Vue에서 컴포넌트를 등록하는 방법은 간단합니다.

		// todo-item 이름을 가진 컴포넌트를 정의합니다.
		Vue.component('todo-item', {
			
		 // 이제 todo-item 컴포넌트는 "prop" 이라고 하는
		 // 사용자 정의 속성 같은 것을 입력받을 수 있습니다.
		 //  이 prop은 todo라는 이름으로 정의했습니다.
			  
			props : [ 'todo' ],
			template :  '<li>{{ todo.text }}</li>'
		})
		// 이제 v-bind를 사용하여 각각의 반복되는 todo-item 컴포넌트에 전달할 수 있습니다. html부분을 볼까요?

		var app7 = new Vue({
			el : '#app-7',
			data : {
				groceryList : [ {
					id : 0,
					text : 'Vegetables'
				}, {
					id : 1,
					text : 'Cheese'
				}, {
					id : 2,
					text : 'Whatever else humans are supposed to eat'
				} ]
			}
		})

		//-----------------------------------------------------------------
		// Vue 인스턴스가 생성될 때 data 객체에 있는 모든 속성이 Vue의 반응형 시스템에 추가됩니다. 
		// 각 속성값이 변경될 때 뷰가 “반응”하여 새로운 값과 일치하도록 업데이트됩니다.

		// 데이터 객체
		var data = {
			a : 1
		}

		// Vue인스턴스에 데이터 객체를 추가합니다.
		var vm = new Vue({
			data : data
		})

		// 인스턴스에 있는 속성은
		// 원본 데이터에 있는 값을 반환합니다.
		vm.a === data.a // => true

		// 인스턴스에 있는 속성값을 변경하면
		// 원본 데이터에도 영향을 미칩니다.
		vm.a = 2
		data.a // => 2

		// ... 반대로 마찬가지입니다.
		data.a = 3
		vm.a // => 3
		
		//-----------------------------------------------------------------
		
		var obj = {
		  foo: 'bar'
		}
		
		Object.freeze(obj)
		
		new Vue({
		  el: '#app-8',
		  data: obj
		})
		
		//-----------------------------------------------------------------
		
		var app9 = new Vue({
			el : '#app-9',
			data : {
				message : 'app9.message = ""해도 변하지 않습니다.'
			}
		})

		
	</script>


</body>
</html>