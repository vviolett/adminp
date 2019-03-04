<#import "common.ftl" as c>
<@c.page>
    <form method="post" enctype="multipart/form-data">
        <div class="card">
            <div class="card-header">
    <#if task.project??>
            ${task.project.text}
    </#if>
            </div>
            <br/>
            <div class="container">
                <div class="row">
                    <div class="col-6">
                        <#if task.filename??>
                            <img src="/img/${task.filename}" class="card-img-top">
                        </#if>
                    </div>
                    <div class="col-2">
                    </div>
                    <div class="col-4" style="text-align: left;">
                        Date
                        <#if task.date??>
                            <i><input type="text" class="form-control" name="datepicker" id="datepicker"
                                      width="276"
                                      placeholder=${task.date}></i><br/>
                        </#if>
                        Executor
                        <br/>
                        <#if task.executor??>
                            <select name="executor" class="custom-select col-md-4" style="width: 560px;">
                                <option value="" disabled selected>${task.executor.username}</option>
                                <#if users??>
                                    <#list users as user>
                                        <option value="${user.id}">${user.username}</option>
                                    </#list>
                                </#if>
                            </select><br/>
                        </#if>
                        <br/>
                        Time
                        <#if task.time??>
                            <input type="text" class="form-control" name="time" placeholder=${task.time}>
                        </#if>
                        <br/>
                        Status
                        <br/>
                        <#if task.statuses??>
                            <p class="text-muted">
                            ${task.getActualStatus()}
                            </p>
                        </#if>
                    </div>
                </div>
            </div>
            <div class="m-2" style="text-align: left;">
                <div class="form-group">
                    <br/><i><input type="text" class="form-control" name="tag" placeholder=${task.tag}></i><br/>
                    <textarea name="text" class="form-control" id="exampleFormControlTextarea1" rows="3"
                              placeholder=${task.text}></textarea><br/>
                    <div class="custom-file">
                        <input type="file" name="file" id="customFile">
                        <label class="custom-file-label" for="customFile">Choose file</label>
                    </div>
                </div>
            </div>
            <div class="m-2">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="<#if task??>${task.id}</#if>"/>
                <div class="form-group">
                    <input name="save" value="save" type="submit" class="btn btn-primary"/>
                    <input name="delete" value="delete" type="submit" class="btn btn-primary"/>
                    <input name="work" value="work" type="submit" class="btn btn-light"/>
                    <input name="resolve" value="resolve" type="submit" class="btn btn-light"/>
                </div>
            </div>
            <div class="card-footer text-muted">
            ${task.authorName}
            </div>
        </div>
    </form>
<br/>
<tbody>
<tr>
    <td><#list task.comments as comment>
        <div class="row">
            <div class="col-1" style="text-align: center;">
                <img src="/img/man.png">
                <#if comment.author??>
                ${comment.author.username}
                </#if>
            </div>
            <div class="col-10">
                <#if comment.date??>
                ${comment.date}
                </#if>
                <textarea class="form-control" id="exampleFormControlTextarea1" rows="3">${comment.text}</textarea><br/>
            </div>
        </div>
    </#list></td>
</tr>
</tbody>
<form method="post" action="addComment" enctype="multipart/form-data">
    <div class="row">
        <div class="col-1" style="text-align: center;">
            <img src="/img/man.png">
        ${task.authorName}
        </div>
        <div class="col-10">
                <textarea name="text" class="form-control" id="exampleFormControlTextarea1" rows="3"
                          placeholder="Введите ваш комментарий"></textarea><br/>
            <div class="text-right">
                <input name="save" value="save" type="submit" class="btn btn-success"/>
            </div>
        </div>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    <input type="hidden" name="id" value="<#if task??>${task.id}</#if>"/>
</form>
</@c.page>