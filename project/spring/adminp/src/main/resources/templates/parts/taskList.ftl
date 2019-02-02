<#include "security.ftl">

<div class="card-columns">
<#list tasks as task>
    <div class="card my-3">
        <#if task.filename??>
            <img src="/img/${task.filename}" class="card-img-top">
        </#if>
        <div class="m-2">
            <span>${task.text}</span><br/>
            <i>${task.tag}</i>
    <#if task.date??>
            <i>${task.date}</i>
    </#if>
            <#if task.executor??>
                <i>${task.executor.username}</i>
            </#if>
        </div>
        <div class="card-footer text-muted">
            ${task.authorName}
                <a class="btn btn-primary" href="/tasks/${task.id}">
                    Edit
                </a>
        </div>
    </div>
<#else>
    No task
</#list>
</div>