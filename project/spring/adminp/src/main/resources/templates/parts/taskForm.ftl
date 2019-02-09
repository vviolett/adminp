<#import "common.ftl" as c>
<@c.page>
<div class="card-columns" xmlns="http://www.w3.org/1999/html">
    <form method="post" enctype="multipart/form-data">
        <div class="card" style="width: 62rem;">
            <div class="card-header">
                ProjName
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
                    <div class="col-4">
                        <#if task.date??>
                            <i><input type="text" class="form-control" name="datepicker" id="datepicker"
                                      width="276"
                                      placeholder=${task.date}/></i><br/>
                        </#if>
                        <#if task.executor??>
                            <select name="executor" class="form-control">
                                <option value="" disabled selected>${task.executor.username}</option>
                                <#if users??>
                                    <#list users as user>
                                        <option value="${user.id}">${user.username}</option>
                                    </#list>
                                </#if>
                            </select>
                        </#if>
                    </div>
                </div>
            </div>
            <div class="m-2">
                <div class="form-group">
                    <i><input type="text" class="form-control" name="tag" placeholder=${task.tag}/></i><br/>
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
                </div>
            </div>
            <div class="card-footer text-muted">
            ${task.authorName}
            </div>
        </div>
    </form>
</div>
<tbody>
<tr>
    <td><#list task.comments as comment>
        <div class="row">
            <div class="col-1">
                <img src="https://downloader.disk.yandex.ru/disk/e9cc5d64a693a87438cd9c815efbce64a03a0c88a385e3e1b7b5292e5528c94a/5c5f69af/9Ks_sHpv0WTyny6h8Wn7svl0zQQIoe8w_Jinxb69C7cna8j9elmoypERXg7p_NdyksF9OZo4AzufWMB9N3BHFA%3D%3D?uid=0&filename=man.png&disposition=inline&hash=&limit=0&content_type=image%2Fpng&fsize=1973&hid=6ee2a01e27939c30598967c21feb1ddf&media_type=image&tknv=v2&etag=34f3713ab4585e9e66dbf8ad9b7258cb">
            </div>
            <div class="col-10">
                <textarea class="form-control" id="exampleFormControlTextarea1" rows="3">${comment.text}</textarea><br/>
            </div>
        </div>
    </#list></td>
</tr>
</tbody>
<form method="post" action="addComment" enctype="multipart/form-data">
    <div class="card my-3">
        <div class="row">
            <div class="col-1">
                <img src="https://downloader.disk.yandex.ru/disk/e9cc5d64a693a87438cd9c815efbce64a03a0c88a385e3e1b7b5292e5528c94a/5c5f69af/9Ks_sHpv0WTyny6h8Wn7svl0zQQIoe8w_Jinxb69C7cna8j9elmoypERXg7p_NdyksF9OZo4AzufWMB9N3BHFA%3D%3D?uid=0&filename=man.png&disposition=inline&hash=&limit=0&content_type=image%2Fpng&fsize=1973&hid=6ee2a01e27939c30598967c21feb1ddf&media_type=image&tknv=v2&etag=34f3713ab4585e9e66dbf8ad9b7258cb">
            </div>
            <div class="col-10">
                <textarea name="text" class="form-control" id="exampleFormControlTextarea1" rows="3"
                          placeholder="Введите ваш комментарий"></textarea>
            </div>
        </div>
        <div class="card-footer text-muted">
        ${task.authorName}
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input type="hidden" name="id" value="<#if task??>${task.id}</#if>"/>
            <div class="form-group">
                <input name="save" value="save" type="submit" class="btn btn-success"/>
            </div>
        </div>
    </div>
</form>
</@c.page>