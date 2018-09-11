<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

#emp .select {
	background: #337ab7
}

#emp td {
	width: 200px;
}

#emp input {
	width: 100px;
}

#emp select {
	width: 100px;
	height: 28px;
}

#emp img {
	width: 30px;
	height: 30px;
}

#bigPhoto {
	display: none;
	position: absolute;
	width: 100px;
}

#bigPhoto img {
	width: 100 px;
	height: 100px;
}
</style>
<link href="bootstrap/css/bootstrap.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	$()
			.ready(
					function() {

						var selectId = -1;
						$("#showAdd").click(function() {
							location.href = "emp?type=showAdd"
						})	
						
						$("#showAdd2").click(function() {
							location.href = "emp?type=showAdd2"
						})
						$("#showUpdate")
								.click(
										function() {
											if (selectId > -1) {
												location.href = "emp?type=showUpdate&id="
														+ selectId
											} else {
												alert("请选中一条数据");
											}
										})
						$("#delete").click(
								function() {
									if (selectId > -1) {
										location.href = "emp?type=delete&id="
												+ selectId
									} else {
										alert("请选中一条数据");
									}
								})

						function doBatch(type) {
							var length = $("#emp .select").length;
							//var ids = "";
							var ids = new Array();
							if (length > 0) {
								$("#emp .select").each(
										function(index, element) {
											ids.push($(this).data("id"));
											//ids += $(this).data("id") + ",";

										})
								//ids = ids.substring(0, ids.length - 1);
								location.href = "emp?type=" + type + "&ids="
										+ ids;
							} else {
								alert("请选中数据");
							}
						}

						$("#deleteBatch").click(function() {
							doBatch("deleteBatch")
						})

						$("#showUpdateBatch1").click(function() {
							doBatch("showUpdateBatch1")

						})
						$("#showUpdateBatch2").click(function() {
							doBatch("showUpdateBatch2")
						})
						$("tr").click(function() {
							$(this).toggleClass("select");
							//selectId=$(this).children().eq(0).text();
							selectId = $(this).data("id");

						})

						$("tr")
								.dblclick(
										function() {

											$(this).unbind("dblclick");
											$(this).unbind("click");
											$(this).addClass("updateEmp");
											var name = $(this).children().eq(0)
													.text();
											$(this)
													.children()
													.eq(0)
													.html(
															"<input type='text' name='name' value='"+name+"'/>");

											var sex = $(this).children().eq(1)
													.text();
											var select = "";
											if (sex == "男") {
												select = "<select name='sex'><option selected value='男'>男</option><option value='女'>女</option></select>"
											} else {
												select = "<select  name='sex'><option value='男'>男</option><option selected value='女'>女</option></select>"

											}
											$(this).children().eq(1).html(
													select);

											var age = $(this).children().eq(2)
													.text();
											$(this)
													.children()
													.eq(2)
													.html(
															"<input type='text' name='age' value='"+age+"'/>");
										})
						$("#updateBatch3")
								.click(
										function() {
											//var emps = "";
											var array = new Array();
											$(".updateEmp")
													.each(
															function(index,
																	element) {
																var id = $(this)
																		.data(
																				"id");
																var name = $(
																		this)
																		.find(
																				"[name=name]")
																		.val();
																var sex = $(
																		this)
																		.find(
																				"[name=sex]")
																		.val();
																var age = $(
																		this)
																		.find(
																				"[name=age]")
																		.val();
																var emp = {
																	id : id,
																	name : name,
																	sex : sex,
																	age : age
																}
																array.push(emp);

															})
											//emps = emps.substring(0, emps.length - 1);
											var str = JSON.stringify(array);
											str = str.replace(/{/g, "%7b");
											str = str.replace(/}/g, "%7d");
											window.location.href = "emp?type=updateBatch3&emps="
													+ str;

										})
						if (${p.ye}<= 1) {
							$("#pre").addClass("disabled");
							$("#pre").find("a").attr("onclick", "return false");
						}

						if (${p.ye}>=${p.maxYe}) {  
							$("#next").addClass("disabled");
							$("#next").find("a")
									.attr("onclick", "return false");
						}
						
						
						$("#emp img").hover(function(event){
						var photo=	$(this).attr("src");
							$("#bigPhoto img").attr("src",photo);
							$("#bigPhoto").show();
							$("#bigPhoto").css({left:event.pageX+10,top:event.pageY+10})
						},function(){$("#bigPhoto").hide();})
						
					})
</script>
</head>
<body>

	<div id="main">
		<form action="emp" class="form-horizontal" role="form" method="post">
			<div class="form-group">
				<div class="col-sm-3">
					<input type="text" class="form-control" name="name"
						placeholder="姓名" value=${c.name}>
				</div>
				<div class="col-sm-2 ">
					<select name="sex" class="form-control">
						<option value="">性别</option>
						<option value="男" <c:if test="${c.sex =='男'}"> selected</c:if>>男</option>
						<option value="女" <c:if test="${c.sex =='女'}"> selected</c:if>>女</option>
					</select>
				</div>
				<div class="col-sm-2">
					<input type="text" class="form-control" name="age" placeholder="年龄"
						value=${c.age!=-1?c.age:''}>
				</div>

				<div class="col-sm-3 ">
					<select name="depId" class="form-control">
						<option value="">部门</option>
						<c:forEach items="${depList}" var="dep">

							<option value="${dep.id }"
								<c:if test="${dep.id ==c.dep.id}"> selected</c:if>>${dep.name }</option>

						</c:forEach>
					</select>
				</div>
				<div class="form-group">
					<div class="col-sm-2">
						<button type="submit" class="btn btn-primary">搜索</button>
					</div>
				</div>
			</div>







		</form>
		<table id="emp" class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th>id</th>
					<th>姓名</th>
					<th>性别</th>
					<th>年龄</th>
					<th>部门</th>
					<th>照片</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${list}" var="emp">

					<tr data-id="${emp.id }">
						<td>${emp.id }</td>
						<td>${emp.name }</td>
						<td>${emp.sex}</td>
						<td>${emp.age}</td>
						<td>${emp.dep.name}</td>
						<td><c:if test="${not empty emp.photo }">
								<img src="pic/${emp.photo}" />
							</c:if></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<ul class="pagination">
			<li><a
				href="emp?ye=1&name=${c.name}&sex=${c.sex}&age=${c.age!=-1?c.age:''}&depId=${c.dep.id }">首页</a></li>
			<li id="pre"><a
				href="emp?ye=${p.ye-1}&name=${c.name}&sex=${c.sex}&age=${c.age!=-1?c.age:''}&depId=${c.dep.id }">上一页</a></li>
			<c:forEach begin="${p.beginYe}" end="${p.endYe}" varStatus="status">
				<li <c:if test="${p.ye==status.index}"> class="active"</c:if>><a
					href="emp?ye=${status.index }&name=${c.name}&sex=${c.sex}&age=${c.age!=-1?c.age:''}&depId=${c.dep.id }">${status.index }</a></li>
			</c:forEach>
			<li id="next"><a
				href="emp?ye=${p.ye+1}&name=${c.name}&sex=${c.sex}&age=${c.age!=-1?c.age:''}&depId=${c.dep.id }">下一页</a></li>
			<li><a
				href="emp?ye=${p.maxYe}&name=${c.name}&sex=${c.sex}&age=${c.age!=-1?c.age:''}&depId=${c.dep.id }">尾页</a></li>
		</ul>
		<div>
			<button id="showAdd" type="button" class="btn btn-primary">增加</button>
			<button id="showAdd2" type="button" class="btn btn-primary">增加2</button>
			<button id="showUpdate" type="button" class="btn btn-primary">修改</button>
			<button id="delete" type="button" class="btn btn-primary">删除</button>
			<button id="showUpdateBatch1" type="button" class="btn btn-primary">批量修改1</button>
			<button id="showUpdateBatch2" type="button" class="btn btn-primary">批量修改2</button>
			<button id="updateBatch3" type="button" class="btn btn-primary">批量修改3</button>

			<button id="deleteBatch" type="button" class="btn btn-primary">批量删除</button>
		</div>
	</div>

	<div id="bigPhoto">
		<img src="" />
	</div>
</body>
</html>