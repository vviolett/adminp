<#include "security.ftl">

<div class="card-columns">
<#list messages as message>
    <div class="card my-3">
        <#if message.filename??>
            <img src="/img/${message.filename}" class="card-img-top">
        </#if>
        <div class="m-2">
            <span>${message.text}</span><br/>
            <i>${message.tag}</i>
        </div>
        <div class="card-footer text-muted">
            ${message.authorName}
                <a class="btn btn-primary" href="/messages/${message.id}">
                    Edit
                </a>
        </div>
    </div>
<#else>
    No message
</#list>
</div>