<#include "security.ftl">
<#import "login.ftl" as l>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/">AdminP</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/">Home</a>
            </li>
        <#if user ??>
            <li class="nav-item">
                <a class="nav-link" href="/main">Tasks</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/user-tasks/${currentUserId}">My tasks</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                ${userProjectsAsString}
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdownMenu2">
                    <a class="dropdown-item" href="#">Action</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/projects">Project Management</a>
            </li>
        </#if>
        <#if isAdmin>
            <li class="nav-item">
                <a class="nav-link" href="/user">User list</a>
            </li>
        </#if>
        <#if springMacroRequestContext.requestUri?contains("/main")>
            <form class="form-inline my-2 my-lg-0" method="get" action="/main">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="filter"
                       value="${filter}">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </#if>
        </ul>

        <div class="navbar-text mr-3">${name}</div>
    <@l.logout />
    </div>
</nav>