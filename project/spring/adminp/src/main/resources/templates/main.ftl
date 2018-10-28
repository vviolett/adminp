<#import "parts/common.ftl" as c>
<@c.page>
<div>
    <form method="post">
        <input type="text" name="text" placeholder="Введите сообщение" />
        <input type="text" name="tag" placeholder="Тэг">
        <button type="submit">Добавить</button>
    </form>
</div>
<div>Список продуктов</div>
<#list products as product>
<div>
    <b>${product.id}</b>
    <span>${product.text}</span>
    <i>${product.tag}</i>
</div>
<#else>
No message
</#list>
</@c.page>
