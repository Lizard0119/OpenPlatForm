<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <style>
        body {
            margin: 10px;
        }
    </style>
</head>
<body>

<script type="text/html" id="barDemo">
    <%--<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>--%>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a> </a>
</script>

<table class="layui-hide" id="table-client" lay-filter="test"></table>

<table id="demo" lay-filter="test"></table>
<script>
    // 必须要导入 table模块 layui.use('table',...)
    layui.use(['laypage', 'layer', 'table', 'element', 'jquery'], function () {
        var table = layui.table //表格
            , laypage = layui.laypage //分页
            , layer = layui.layer //弹层
            , element = layui.element //元素操作
            , $ = layui.jquery
        // 为表格填充数据
        table.render({
            elem: '#demo'
            , height: 480
            , toolbar: 'default'
            , page: true
            , url: 'UserLayUI' //获取数据
            ,totalRow: true //开启合计行
            , page: {
                limit: 5//每页显示5条
                , limits: [1, 2, 3, 4, 5, 6] //可选每页条数
                , first: '首页' //首页显示文字，默认显示页号
                , last: '尾页'
                ,theme: '#FF8422'
                , prev: '<em>☜</em>' //上一页显示内容，默认显示 > <
                , next: '<em>☞</em>' //上一页显示内容，默认显示 > <
                , next: '<i class="layui-icon layui-icon-next"></i>'
                , layout: ['prev', 'page', 'next', 'count', 'limit', 'skip'] //自定义分页布局
            } //开启分页
            , cols: [[ //表头
                {type: 'checkbox'}
                , {field: 'id', title: 'ID', sort: true}
                , {field: 'username', title: '用户名', sort: true}
                , {field: 'nickname', title: '公司名称'} //没定义宽度则占满剩余所有宽度，都不定义则所有列均分
                , {field: 'address', title: '地址'}
                , {field: "money", title: "余额", sort: true}
                , {field: "state", title: "状态"}
                , {field: "right", title: "操作", toolbar: '#barDemo'}
            ]]
        });


        //监听头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id)
                ,data = checkStatus.data; //获取选中的数据
            switch(obj.event){
                case 'add':
                    layer.msg('添加');
                    layer.open({
                        type: 2,
                        title: '新增客户',
                        shadeClose: true,
                        shade: 0.5,
                        area: ['540px', '78%'],
                        shadeClose: false,
                        content: 'insert', //iframe的url
                        end:function () {
                            window.location.href = 'saveUser', target = 'content';
                        }
                    })
                    break;
                case 'update':
                    if(data.length === 0){
                        layer.msg('请选择一行');
                    } else if(data.length > 1){
                        layer.msg('只能同时编辑一个');
                    } else {
                        layer.alert('编辑 [id]：'+ checkStatus.data[0].id);
                    }
                    break;
                case 'delete':
                    if(data.length === 0){
                        layer.msg('请选择一行');
                    } else {
                        layer.msg('删除');
                    }
                    break;
            };
        });


        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            /*if(layEvent === 'detail'){
                layer.msg('查看操作');
                layer.open({
                    type: 2,
                    title: '查看客户信息',
                    shadeClose: true,
                    shade: 0.8,
                    area: ['480px', '72%'],
                    shadeClose: false,
                    content: '../SelectClient/' + data.id //iframe的url
                })
            } else */if(layEvent === 'del'){
                // console.log(data.id);
                layer.confirm('是否删除用户' + data.nickname, function(index){
                    $.get("removeUser/" + data.id , function (res) {
                        if (res == "success") {
                            layer.msg('删除成功',  {time: 1800}, function () {
                                layer.close(index);
                                window.location.href = 'saveUser', target = 'content';
                            });
                        } else {
                            layer.msg('删除失败', {time:1800}, function () {
                                layer.close(index);
                            });
                        }
                    })
                    // obj.del(); //删除对应行（tr）的DOM结构

                    //向服务端发送删除指令
                });
            } else if(layEvent === 'edit'){
                layer.msg('编辑操作');
                layer.open({
                    type: 2,
                    title: '客户信息修改',
                    shadeClose: true,
                    shade: 0.5,
                    area: ['540px', '78%'],
                    shadeClose: false,
                    content: 'updateUser/' + data.id, //iframe的url
                    end:function () {
                        window.location.href = 'saveUser', target = 'content';
                    }
                })
            }
        });

        // //监听行单击事件（双击事件为：rowDouble）
        // table.on('row(test)', function(obj){
        //     var data = obj.data;
        //
        //     layer.alert(JSON.stringify(data), {
        //         title: '当前行数据：'
        //     });
        //
        //     //标注选中样式
        //     obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
        // });



        // // 事件注册   // //分页
        // laypage.render({
        //     elem: 'pageDemo' //分页容器的id
        //     ,count: 100 //总页数
        //     ,skin: '#1E9FFF' //自定义选中色值
        //     //,skip: true //开启跳页
        //     ,jump: function(obj, first){
        //         if(!first){
        //             layer.msg('第'+ obj.curr +'页', {offset: 'b'});
        //         }
        //     }
        // });

        // table.on('tool(test)', function (obj) {
        //     var data = obj.data; //获得当前行数据
        //     //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
        //     var layEvent = obj.event;
        //     var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
        //     if (layEvent === 'del') { //删除
        //         layer.confirm('真的删除行么', function (index) {
        //             // 向服务端发送删除请求+
        //             // 此处可以发送ajax
        //             obj.del(); //删除对应行（tr）的DOM结构
        //
        //             layer.close(index);
        //         });
        //     } else if (layEvent === 'edit') { //编辑
        //         // 向服务端发送更新请求
        //         // 同步更新缓存对应的值
        //         obj.update({
        //             username: 'shine001',
        //             city: '北京',
        //             sex: '女',
        //             score: 99
        //         });
        //     }
        // });
    });
</script>

</body>
</html>
