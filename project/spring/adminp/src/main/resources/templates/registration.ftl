<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
Add new user
${task?ifExists}
    <@l.login "/registration" true/>
</@c.page>