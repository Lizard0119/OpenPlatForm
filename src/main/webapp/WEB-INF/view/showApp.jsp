<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css"  media="all">
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <style>
        body {
            margin: 10px;
        }
    </style>
</head>
<body>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a> </a>
</script>


<div class="demoTable">
    搜索ID：
    <div class="layui-inline">
        <input class="layui-input" name="id" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>

<table class="layui-hide" id="table-client" lay-filter="test"></table>

<table id="demo" lay-filter="test"></table>
<script>
    // 必须要导入 table模块 layui.use('table',...)
    layui.use(['laypage', 'layer', 'table', 'element'], function () {
        var table = layui.table //表格
            , layer = layui.layer;//弹层
        // , $ = layui.jquery
        // 为表格填充数据
        table.render({
            elem: '#demo'
            , height: 480
            , toolbar: 'default'
            , id: 'testReload'
            , page: true
            , url: 'AppLayUI' //获取数据
            , totalRow: true //开启合计行
            , page: {
                limit: 5//每页显示5条
                , limits: [1, 2, 3, 4, 5, 6] //可选每页条数
                , first: '首页' //首页显示文字，默认显示页号
                , last: '尾页'
                , theme: '#FF8422'
                , prev: '<em>☜</em>' //上一页显示内容，默认显示 > <
                , next: '<em>☞</em>' //上一页显示内容，默认显示 > <
                // , next: '<i class="layui-icon layui-icon-next"></i>'
                , layout: ['prev', 'page', 'next', 'count', 'limit', 'skip'] //自定义分页布局
            } //开启分页
            , cols: [[ //表头
                {type: 'checkbox'}
                // {checkbox: true, fixed: true}
                , {field: 'id', title: 'ID', sort: true}
                , {field: 'corpName',title: '公司'}
                , {field: 'appName', title: '应用名称'} //没定义宽度则占满剩余所有宽度，都不定义则所有列均分
                , {field: 'appKey', title: '唯一标识Key', sort: true}
                , {field: "appSecret", title: "签名秘钥", sort: true}
                , {field: "redirectUrl", title: "回调URL"}
                , {field: "linit",title: "免费限制次数", sort: true}
                , {field: "description", title: "应用介绍"}
                , {field: "state", title: "状态" }
                , {field: "right", title: "操作", toolbar: '#barDemo'}
            ]]
        });

        var $ = layui.$,
            active = {
                reload: function () {
                    var demoReload = $('#demoReload');

                    //执行重载
                    table.reload('testReload', {
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {
                            key: {
                                id: demoReload.val()
                            }
                        }
                    }, 'data');
                }
            };

        $('.demoTable .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        //监听头工具栏事件
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id)
                , data = checkStatus.data; //获取选中的数据
            switch (obj.event) {
                case 'add':
                    layer.msg('添加');
                    layer.open({
                        type: 2,
                        title: '新增客户',
                        shadeClose: true,
                        shade: 0.5,
                        area: ['540px', '78%'],
                        shadeClose: false,
                        content: 'insertA', //iframe的url
                        end: function () {
                            window.location.href = 'showApp', target = 'content';
                        }
                    })
                    break;
                case 'update':
                    if (data.length === 0) {
                        layer.msg('请选择一行');
                    } else if (data.length > 1) {
                        layer.msg('只能同时编辑一个');
                    } else {
                        layer.alert('编辑 [id]：' + checkStatus.data[0].id);
                    }
                    break;
                case 'delete':
                    if (data.length === 0) {
                        layer.msg('请选择一行');
                    } else {
                        layer.msg('删除成功', {time: 1800}, function (index) {
                            layer.close(index);
                            window.location.href = 'showApp', target = 'content';
                        });
                    }
                    break;
            }
            ;
        });


        //监听行工具事件
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail') {
                layer.msg('查看操作');
                layer.open({
                    type: 2,
                    title: '查看客户信息',
                    shadeClose: true,
                    shade: 0.8,
                    area: ['380px', '42%'],
                    shadeClose: false,
                    content: 'getAppById/' + data.id //iframe的url
                })
            } else if (layEvent === 'del') {
                // console.log(data.id);
                layer.confirm('是否删除用户' + data.nickname, function (index) {
                    $.get("removeApp/" + data.id, function (res) {
                        if (res == "success") {
                            layer.msg('删除成功', {time: 1800}, function () {
                                layer.close(index);
                                window.location.href = 'showApp', target = 'content';
                            });
                        } else {
                            layer.msg('删除失败', {time: 1800}, function () {
                                layer.close(index);
                            });
                        }
                    })
                    // obj.del(); //删除对应行（tr）的DOM结构

                    //向服务端发送删除指令
                });
            } else if (layEvent === 'edit') {
                layer.msg('编辑操作');
                layer.open({
                    type: 2,
                    title: '客户信息修改',
                    shadeClose: true,
                    shade: 0.5,
                    area: ['540px', '78%'],
                    shadeClose: false,
                    content: 'updateApp/' + data.id, //iframe的url
                    end: function () {
                        window.location.href = 'showApp', target = 'content';
                    }
                })
            }
        });
    });
</script>

</body>
</html>
