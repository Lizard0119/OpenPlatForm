<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <style>
        body{margin: 10px;}
    </style>
</head>
<body>

<table class="layui-hide" id="table-client" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a id="del-client" class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<table id="demo" lay-filter="test"></table>
<script>
    // 必须要导入 table模块 layui.use('table',...)
    layui.use('table', function(){
        var table = layui.table;
        // 为表格填充数据
        table.render({
            elem: '#demo'
            ,height: 480
            ,toolbar:true
            ,url: 'UserLayUI' //获取数据
            // ,page: {limit:2//每页显示1条
            //     ,limits:[1,2,3] //可选每页条数
            //     ,first: '首页' //首页显示文字，默认显示页号
            //     ,last: '尾页'
            //     ,prev: '<em>←</em>' //上一页显示内容，默认显示 > <
            //     ,next: '<i class="layui-icon layui-icon-next"></i>'
            //     ,layout:['prev', 'page', 'next','count','limit','skip','refresh'] //自定义分页布局
            // } //开启分页
            ,page:true
            ,cols: [[ //表头
                {field:'id', title: 'ID', sort: true}
                ,{field:'username',  title: '用户名',sort: true}
                ,{field:'nickname',  title: '公司名称'} //没定义宽度则占满剩余所有宽度，都不定义则所有列均分
                ,{field:'address', title: '地址'}
                ,{field:"money", title:"余额", sort: true}
                ,{field:"state", title:"状态",toolbar: '#barDemo'}
                ,{field:"right", title:"操作",toolbar: '#barDemo1'}
            ]]
        });

        // 事件注册
        table.on('tool(test)', function(obj){
            var data = obj.data; //获得当前行数据
            //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var layEvent = obj.event;
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if(layEvent === 'del'){ //删除
                layer.confirm('真的删除行么', function(index){
                    // 向服务端发送删除请求+
                    // 此处可以发送ajax
                    obj.del(); //删除对应行（tr）的DOM结构

                    layer.close(index);
                });
            } else if(layEvent === 'edit'){ //编辑
                // 向服务端发送更新请求
                // 同步更新缓存对应的值
                obj.update({
                    username: 'shine001',
                    city: '北京',
                    sex:'女',
                    score:99});
            }
        });
    });
</script>

<!-- 如下script可以定义在页面的任何位置 -->
<%--<script type="text/html" id="barDemo">--%>
    <%--<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>--%>
    <%--<a id="del-client" class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="edit">有效</a>--%>
    <%--<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
<%--</script>--%>

<%--<script type="text/html" id="barDemo1">--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="edit" readonly="true">编辑</a>--%>
    <%--&lt;%&ndash;<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>&ndash;%&gt;--%>
<%--</script>--%>
</body>
</html>
