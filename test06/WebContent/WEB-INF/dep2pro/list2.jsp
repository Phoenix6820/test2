<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
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
#main {
	width: 600px;
	margin: 20px auto;
}

#pro .select {
	background: #337ab7
}

#pro td {
	width: 200px;
}

#pro input {
	width: 100px;
}

#pro select {
	width: 100px;
	height: 28px;
}
</style>
<link href="bootstrap/css/bootstrap.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$().ready(function() {

		var selectId = -1;
		$("#add").click(function() {
		var proId=	$("#selectPro").val();
		
		var i=0;
			//location.href = "d2p?type=add&depId=${dep.id}&proId="+proId;  			
			$.ajax({
				url:"d2p",
				type:"post",
				data:{type:"add2", depId:${dep.id},proId:proId  } , 
				dataType:"text",
				success:function(data){
				  if(data=="true"){
					  var proName="";
					  $("#selectPro").children().each(function(index,element){
						  if($(this).val()==proId){
							  proName=$(this).text();
							  i=index;
						  }
						  
					  })
					  var tr="<tr><td>"+proId+"</td><td>"+proName+"</td></tr>"
					  $("#pro").append(tr)
					 $("#selectPro").children().eq(i).remove();  
						if($("#selectPro").children().length==0){

							$("#add").unbind("click");
							$("#add").addClass("disabled");
							
						}
				  }
				  
				}
				
			})
		})

		

	
		
		$("#delete").click(function() {
			if (selectId > -1) {
			
					
					var i=0;
						//location.href = "d2p?type=add&depId=${dep.id}&proId="+proId;  			
						$.ajax({
							url:"d2p",
							type:"post",
							data:{type:"delete2", depId:${dep.id},proId:selectId  } , 
							dataType:"text",
							success:function(data){
							  if(data=="true"){
								  var proName="";
								  $("tr").each(function(index,element){
									  if($(this).data("id")==selectId){
										  proName=$(this).children().eq(1).text();
										  i=index;
									  }
									  
								  })
								  var option="<option value='"+selectId+"'>"+proName+"</option>"
								  $("#selectPro").append(option)
								 $("tr").eq(i).remove();  
									
							  }
							  
							}
							
						})
				

			} else {
				alert("请选中一条数据");
			}
		})

		$(document).on("click","tr",function() {
			$(this).toggleClass("select");
			//selectId=$(this).children().eq(0).text();
			selectId = $(this).data("id");

		})

	})
</script>
</head>
<body>

	<div id="main">

		<h2>${dep.name}</h2>

		<table id="pro" class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th>id</th>
					<th>名称</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${list}" var="pro">

					<tr data-id="${pro.id }">
						<td>${pro.id }</td>
						<td>${pro.name }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div>
			<div class="col-sm-4">
				<select class="form-control" id="selectPro">
					<c:forEach items="${noList}" var="pro">
						<option value="${pro.id }">${pro.name }</option>
					</c:forEach>
				</select>
			</div>


			<button id="add" type="button" class="btn btn-primary">增加</button>
			<button id="delete" type="button" class="btn btn-primary">删除</button>

		</div>
	</div>
</body>
</html>