<#include "security.ftl">

<#assign activeSB = "ACTIVE" >
<#assign progressSB = "PROGRESS" >
<#assign resolvedSB = "RESOLVED" >

<#assign highPR = "HIGH" >
<#assign lowPR = "LOW" >
<#assign avgPR = "AVG" >


<div class="container mt-5">
    <div class="row justify-content-start">

        <div class="col-auto mb-3">
            <div style="background: rgba(248,248,248,0.98);">
            <div class="container" style=" width: 21rem;">
                <br/>
                <p class="font-weight-light">ACTIVE</p>
            <#list tasks as task>
                <#if task.statuses?? && task.getActualStatus() == activeSB>
                    <br/>
                    <div class="card style=" width: 30rem;
                    ">
                    <div class="m-2">
                        <span>${task.text}</span><br/>
                        <i>${task.tag}</i>
                        <br/>
                        <#if task.date??>
                            <i>${task.date}</i>
                        </#if>
                        <#if task.executor??>
                            <i>${task.executor.username}</i>
                        </#if>
                        <a class="btn btn-default" href="/tasks/${task.id}" aria-label="Settings">
                            <i class="fa fa-cog" aria-hidden="true"></i>
                        </a>
                        <#if task.isBlocker()>
                            <i class="fa fa-ban" aria-hidden="true" style="color:#df4738"></i>
                        </#if>
                        <#if task.priority?? && task.getPriority() == highPR>
                            <i class="fa fa-arrow-up" aria-hidden="true" style="color:#df4738"></i>
                        </#if>
                        <#if task.priority?? && task.getPriority() == avgPR>
                            <i class="fa fa-arrow-right" aria-hidden="true" style="color:#e37b00"></i>
                        </#if>
                        <#if task.priority?? && task.getPriority() == lowPR>
                            <i class="fa fa-arrow-down" aria-hidden="true" style="color:#00b312"></i>
                        </#if>
                    </div>
                </div>
                    <br/>
                </#if>
            <#else>
                No task
            </#list>
            </div>
        </div>

    </div>

    <div class="row justify-content-end">
        <div class="col-auto mb-3">
            <div style="background: rgba(248,248,248,0.98);">
            <div class="container" style=" width: 21rem;">
                <br/>
                <p class="font-weight-light">PROGRESS</p>
            <#list tasks as task>
                <#if task.statuses?? && task.getActualStatus() == progressSB>
                    <br/>
                    <div class="card style=" width: 30rem;
                    ">
                    <div class="m-2">
                        <span>${task.text}</span><br/>
                        <i>${task.tag}</i>
                        <br/>
                        <#if task.date??>
                            <i>${task.date}</i>
                        </#if>
                        <#if task.executor??>
                            <i>${task.executor.username}</i>
                        </#if>
                        <a class="btn btn-default" href="/tasks/${task.id}" aria-label="Settings">
                            <i class="fa fa-cog" aria-hidden="true"></i>
                        </a>
                        <#if task.isBlocker()>
                            <i class="fa fa-ban" aria-hidden="true" style="color:#df4738"></i>
                        </#if>
                        <#if task.priority?? && task.getPriority() == highPR>
                            <i class="fa fa-arrow-up" aria-hidden="true" style="color:#df4738"></i>
                        </#if>
                        <#if task.priority?? && task.getPriority() == avgPR>
                            <i class="fa fa-arrow-right" aria-hidden="true" style="color:#e37b00"></i>
                        </#if>
                        <#if task.priority?? && task.getPriority() == lowPR>
                            <i class="fa fa-arrow-down" aria-hidden="true" style="color:#00b312"></i>
                        </#if>
                    </div>
                </div>
                    <br/>
                </#if>
            <#else>
                No task
            </#list>
            </div>
        </div>
    </div>

    <div class="col-auto mb-3">
        <div style="background: rgba(248,248,248,0.98);">
        <div class="container" style=" width: 21rem;">
            <br/>
            <p class="font-weight-light">RESOLVED</p>
        <#list tasks as task>
            <#if task.statuses?? && task.getActualStatus() == resolvedSB>
                <br/>
                <div class="card style=" width: 30rem;
                ">
                <div class="m-2">
                    <span>${task.text}</span><br/>
                    <i>${task.tag}</i>
                    <br/>
                    <#if task.date??>
                        <i>${task.date}</i>
                    </#if>
                    <#if task.executor??>
                        <i>${task.executor.username}</i>
                    </#if>
                    <a class="btn btn-default" href="/tasks/${task.id}" aria-label="Settings">
                        <i class="fa fa-cog" aria-hidden="true"></i>
                    </a>
                    <#if task.isBlocker()>
                        <i class="fa fa-ban" aria-hidden="true" style="color:#df4738"></i>
                    </#if>
                    <#if task.priority?? && task.getPriority() == highPR>
                        <i class="fa fa-arrow-up" aria-hidden="true" style="color:#df4738"></i>
                    </#if>
                    <#if task.priority?? && task.getPriority() == avgPR>
                        <i class="fa fa-arrow-right" aria-hidden="true" style="color:#e37b00"></i>
                    </#if>
                    <#if task.priority?? && task.getPriority() == lowPR>
                        <i class="fa fa-arrow-down" aria-hidden="true" style="color:#00b312"></i>
                    </#if>
                </div>
            </div>
                <br/>
            </#if>
        <#else>
            No task
        </#list>
        </div>
    </div>
</div>
</div>

