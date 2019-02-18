<div class="collapse" id="collapseExample">
    <div class="form-group mt-3">
        <form method="post" enctype="multipart/form-data">
            <div class="form-group">
                <input type="text" class="form-control" name="datepicker" id="datepicker" width="276" />
            </div>

            <div class="form-group">
                <input type="text" class="form-control" name="tag" placeholder="Тэг">
            </div>
            <div class="form-group">
                <textarea name="text" class="form-control" id="exampleFormControlTextarea1" rows="3" placeholder="Введите сообщение"></textarea>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input type="file" name="file" id="customFile">
                    <label class="custom-file-label" for="customFile">Choose file</label>
                </div>
            </div>
            <div class="form-group">
            <select name="executor" class="custom-select col-md-2">
            <#if users??>
                <#list users as user>
                    <option value="${user.id}">${user.username}</option>
                </#list>
            </#if>
            </select>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Добавить</button>
            </div>
        </form>
    </div>
</div>