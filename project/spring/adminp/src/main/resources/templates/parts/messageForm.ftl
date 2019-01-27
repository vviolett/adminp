<#import "common.ftl" as c>
<@c.page>
<div class="card-columns">
    <form method="post" enctype="multipart/form-data">
    <div class="card my-3">
        <#if message.filename??>
            <img src="/img/${message.filename}" class="card-img-top">
        </#if>
        <div class="m-2">
            <span><input type="text" class="form-control" name="text" placeholder=${message.text} /><br/>
            <i><input type="text" class="form-control" name="tag" placeholder=${message.tag}></i>
        </div>
        <div class="card-footer text-muted">
        ${message.authorName}
        </div>
        <div class="form-group">
            <div class="custom-file">
                <input type="file" name="file" id="customFile">
                <label class="custom-file-label" for="customFile">Choose file</label>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <input type="hidden" name="id" value="<#if message??>${message.id}</#if>" />
        <div class="form-group">
            <button type="submit" class="btn btn-primary">Сохранить</button>
        </div>
    </div>
    </form>
</div>
</@c.page>