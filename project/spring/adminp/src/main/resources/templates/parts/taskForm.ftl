<#import "common.ftl" as c>
<@c.page>
<div class="card-columns">
    <form method="post" enctype="multipart/form-data">
        <div class="card my-3">
            <#if task.filename??>
                <img src="/img/${task.filename}" class="card-img-top">
            </#if>
            <div class="m-2">
            <span><div class="form-group">
                <textarea name="text" class="form-control" id="exampleFormControlTextarea1" rows="3" placeholder=${task.text}></textarea>
            </div><br/>
                <i><input type="text" class="form-control" name="tag" placeholder=${task.tag} /></i> <br/>

                <#if task.date??>
                    <i><input type="text" class="form-control" name="datepicker" id="datepicker" width="276" placeholder=${task.date}/></i><br/>
                </#if>
                <#if task.executor??>
                    <select name="executor" class="form-control">
                            <option value="" disabled selected>${task.executor.username}</option>
                        <#if users??>
                            <#list users as user>
                                <option value="${user.id}">${user.username}</option>
                            </#list>
                        </#if>
                        </select><br/>
                </#if>
                <div class="form-group">
                    <div class="custom-file">
                        <input type="file" name="file" id="customFile">
                        <label class="custom-file-label" for="customFile">Choose file</label>
                    </div>
                </div>

            </div>
            <div class="card-footer text-muted">
            ${task.authorName}
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <input type="hidden" name="id" value="<#if task??>${task.id}</#if>" />
            <div class="form-group">
                <input name="save" value="save" type="submit" class="btn btn-primary"/>
                <input name="delete" value="delete" type="submit" class="btn btn-primary"/>
            </div>
        </div>
    </form>
</div>
<tbody>
<tr>
    <td><#list task.comments as comment>
        <textarea class="form-control" id="exampleFormControlTextarea1" rows="3">${comment.text}</textarea>
        <#sep>,
    </#list></td>
</tr>
</tbody>
<form method="post" action="addComment" enctype="multipart/form-data">
    <div class="card my-3">
        <div class="m-2">
            <span><div class="form-group">
                <textarea name="text" class="form-control" id="exampleFormControlTextarea1" rows="3" placeholder="Введите ваш комментарий"></textarea>
            </div>
        </div>
        <div class="card-footer text-muted">
        ${task.authorName}
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <input type="hidden" name="id" value="<#if task??>${task.id}</#if>" />
        <div class="form-group">
            <input name="save" value="save" type="submit" class="btn btn-success"/>
        </div>
        </div>
    </div>
</form>
</@c.page>