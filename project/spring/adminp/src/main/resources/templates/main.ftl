<#import "parts/common.ftl" as c>

<@c.page>


<a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    Add new Task
</a>
    <#include "parts/taskEdit.ftl" />

    <#include "parts/taskList.ftl" />
</@c.page>