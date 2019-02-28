<#import "parts/common.ftl" as c>

<@c.page>

<form method="post" enctype="multipart/form-data">
    <div class="card">
        <div class="m-2" style="text-align: left;">
            <div class="form-group">
                <i><input type="text" class="form-control" name="tag" placeholder=${project.text}></i><br/>
                <#list users as user>
                    <div class="custom-control custom-checkbox">
                        <label>
                            <input type="checkbox" name="${user.username}" ${project.projectUsers?seq_contains(user)?string("checked", "")}>
                        ${user.username}</label>
                    </div>
                </#list>
            </div>
        </div>
        <div class="m-2">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input type="hidden" name="projectId" value="<#if project??>${project.id}</#if>"/>
            <div class="form-group">
                <input name="save" value="save" type="submit" class="btn btn-primary"/>
            </div>
        </div>
    </div>
</form>
</@c.page>