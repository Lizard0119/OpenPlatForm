<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>orders</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- 可选的Bootstrap主题文件（一般不使用） -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"></script>
</head>
<body>
<h1 align="center"><a href="saveEmp" >点击此处进行添加</a></h1>


<c:if test="${list!=null}">

    <table class="table table-striped table-bordered table-hover">
        <tr>
            <th>id</th>
            <th>username</th>
            <th>password</th>
            <th>nickname</th>
            <th>address</th>
            <th>money</th>
            <th>state</th>
            <th>操作</th>
        </tr>

        <c:forEach items="${list}" var="u">
            <tr>
                <td>&nbsp;${u.id}</td>
                <td>&nbsp;${u.username}</td>
                <td>&nbsp;${u.password}</td>
                <td>&nbsp;${u.nickname}</td>
                <td>&nbsp;${u.address}</td>
                <td>&nbsp;${u.money}</td>
                <td>&nbsp;${u.state}</td>
                <td>&nbsp;<a href="getEmpByEid?eid=${e.eid}">更新</a><br/>&nbsp;<a href="deleteEmp/${e.eid}">删除</a></td>
            </tr>
        </c:forEach>
    </table>

</c:if>
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
