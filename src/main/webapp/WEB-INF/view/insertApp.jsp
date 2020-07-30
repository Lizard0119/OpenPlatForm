<%@ page contentType="text/html;charset=UTF-8" language="java" %><html>
<head>
    <meta content="text/html" charset="utf-8" language="java">
    <title>Layui</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <!--注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的-->
    <style>
        .client-input {
            width: 75%;
        }

        #save-client {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<form id="save-client" class="layui-form" lay-filter="example">

    <div class="layui-form-item">
        <label class="layui-form-label">公司名称</label>
        <div class="layui-input-block">
            <input name="corpName" class="layui-input client-input" type="text" placeholder="请输入公司名称" autocomplete="off"
                   lay-verify="title" lay-reqText="公司名不能为空">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">应用名称</label>
        <div class="layui-input-block">
            <input name="appName" class="layui-input client-input" type="text " placeholder="请输入应用名称" autocomplete="off"
                   lay-verify="title" lay-reqText="应用名称不能为空">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">唯一标识</label>
        <div class="layui-input-block">
            <input name="appKey" class="layui-input client-input" type="text" placeholder="请输入唯一Key" autocomplete="off"
                   lay-verify="required" lay-reqText="Key不能为空">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">签名秘钥</label>
        <div class="layui-input-block">
            <input name="appSecret" class="layui-input client-input" type="text" placeholder="请输入签名秘钥" autocomplete="off"
                   lay-verify="appSecret">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">回调URL</label>
        <div class="layui-input-block">
            <input name="redirectURL" class="layui-input client-input" type="text" placeholder="请输入回调URL" autocomplete="off"
                   lay-verify="required" lay-reqText="回调地址URL不能为空">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">免费次数</label>
        <div class="layui-input-block">
            <input name="linit" class="layui-input client-input" type="number" placeholder="请输入免费限制次数" autocomplete="off"
                   lay-verify="linit" lay-reqText="免费次数不能为负数">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">应用介绍</label>
        <div class="layui-input-block">
            <input name="description" class="layui-input client-input" type="text" placeholder="请输入应用介绍" autocomplete="off"
                   lay-verify="">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">关联ID</label>
        <div class="layui-input-block">
            <input name="cusId" class="layui-input client-input" type="number" placeholder="请输入关联ID" autocomplete="off"
                   lay-verify="required" lay-reqText="关联ID">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-block">
            <input name="state" title="正常" type="radio" checked="" value="1">
            <input name="state" title="停用" type="radio" value="0">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button id="save-btn" class="layui-btn" type="submit" lay-filter="demo1" lay-submit="">立即提交</button>
            <button class="layui-btn layui-btn-primary" type="reset">重置</button>
        </div>
    </div>
</form>

<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['form', 'jquery', 'layer','layedit','laydate'], function () {
        var form = layui.form
            , $ = layui.jquery
            , layedit = layui.layedit

        var editIndex = layedit.build('LAY_demo_editor');


        //自定义验证规则
        form.verify({
            title: function (value) {
                if (value.length < 1) {
                    return '用户名不得为空';
                }
            }
            ,linit: function (value) {
                if (value < 0)
                    return '限制次数只能为正数。';
            }
            ,content:function (value) {
                layedit.sync(editIndex);
            }
        });

        form.on('submit(demo1)', function (data) {
            console.log(data.field);

            $.post("/insertApp", {
                // id:data.field.id,
                corpName:data.field.corpName,
                appName:data.field.appName,
                appKey:data.field.appKey,
                appSecret:data.field.appSecret,
                redirectUrl:data.field.redirectUrl,
                linit:data.field.linit,
                description:data.field.description,
                cusId:data.field.cusId,
                state:data.field.state,
            }, function (res) {
                if (res == "success") {
                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                    setTimeout(function () { parent.layer.close(index) }, 100);//延迟
                }
            });
            return false;
        });
    });
</script>

</body>
</html>