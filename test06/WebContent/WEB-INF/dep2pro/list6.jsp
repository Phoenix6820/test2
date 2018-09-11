<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>


<style>
/*table {
	border: 1px solid #000;
	border-collapse: collapse;
	width: 400px;
}
td {
	border: 1px solid #000;
}
table tr:nth-child(1){
	background:#666; 
}*/
#project {
	width: 600px;
	margin: 20px auto;
}

#project #pro, #noPro {
	width: 560px;
	height: 200px;
	border: 1px solid #337ab7;
	border-radius: 3px;
}

#project #btn {
	width: 120px;
	margin: 20px auto;
}

#add {
	margin-right: 50px;
}

#project .pro {
	background: #337ab7;
	height: 40px;
	line-height: 40px;
	float: left;
	margin-left: 5px;
	color: #fff;
	padding: 0 20px;
	margin-top: 10px;
	border-radius: 3px;
}

#project .select {
	background: #d9534f;
}
</style>



<script type="text/javascript">
	$().ready(function() {

		$("#project .pro").click(function() {

			$(this).toggleClass("select")

		})
		
		$("#project #add").click(function(){
			
		if($("#project #noPro").find(".select").length>0){
			
			var proId=$("#project #noPro").find(".select").data("id");
			$.ajax({
				url:"d2p",
				type:"post",
				data:{type:"add2", depId:${dep.id},proId:proId} , 
				dataType:"text",
				success:function(data){
					if(data=="true"){
						var pro=$("#project #noPro").find(".select");
						pro.removeClass("select");
						$("#pro").append(pro);
					}
					
				}
				
				
			})
			
		}else{
			alert("请选择数据");
			
		}
		
		})
		
			
		$("#project #delete").click(function(){
			
			if($("#project #pro").find(".select").length>0){
				
				var proId=$("#project #pro").find(".select").data("id");
				$.ajax({
					url:"d2p",
					type:"post",
					data:{type:"delete2", depId:${dep.id},proId:proId} , 
					dataType:"text",
					success:function(data){
						if(data=="true"){
							var pro=$("#project #pro").find(".select");
							pro.removeClass("select");
							$("#noPro").append(pro);
						}
						
					}
					
					
				})
				
			}else{
				alert("请选择数据");
				
			}})
	})
	
</script>


	<div id="project">

		<h2>${dep.name}</h2>
		<div id="pro">

			<c:forEach items="${list }" var="pro">

				<div class="pro" data-id=${pro.id}>${pro.name }</div>

			</c:forEach>

		</div>
		<div id="btn">
			<button id="add" type="button" class="btn btn-primary">↑</button>
			<button id="delete" type="button" class="btn btn-primary">↓</button>
		</div>
		<div id="noPro">
			<c:forEach items="${noList }" var="pro">

				<div class="pro" data-id="${pro.id }">${pro.name }</div>

			</c:forEach>
		</div>
	</div>
