<#import "parts/common.ftl" as c>

<@c.page>


<a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    Add new Task
</a>
<br/>
<select name="executor" class="custom-select col-md-2">
        <#list projects as project>
            <option value="${project.id}">${project.text}</option>
        </#list>
</select>

<div class="dropdown">
    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        Dropdown button
    </button>
    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    <#list projects as project>
        <a class="dropdown-item" href="/main/${project.id}">${project.text}</a>
    </#list>
    </div>
</div>
    <#include "parts/taskEdit.ftl" />

    <#include "parts/taskList.ftl" />
</@c.page>