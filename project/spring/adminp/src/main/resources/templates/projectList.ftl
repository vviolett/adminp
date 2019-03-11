<#import "parts/common.ftl" as c>

<@c.page>

<a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    Add new Project
</a>
<br/>
<div class="collapse" id="collapseExample">
    <div class="form-group mt-3">
        <form method="post" enctype="multipart/form-data">
            <div class="form-group">
                <input type="text" class="form-control" name="tag" placeholder="Наименование проекта">
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Добавить</button>
            </div>
        </form>
    </div>
</div>
<br/>
<table class="table">
    <thead>
    <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Users</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
        <#list projects as project>
        <tr>
            <td>${project.id}</td>
            <td>${project.text}</td>
            <#if project.projectUsers??>
            <td><#list project.projectUsers as user>${user.username}<#sep>, </#list></td>
            </#if>
            <td><a href="/projects/${project.id}">edit</a></td>
        </tr>
        </#list>
    </tbody>
</table>

</@c.page>
