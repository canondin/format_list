" format_to_list.vim
" 插件名称: FormatToList
" 功能: 格式化多行文本为括号包裹的单引号逗号分隔字符串
" 安装: 将此文件保存到 ~/.vim/plugin 目录下

function! FormatToList()
    " 保存当前选中区域
    let l:old_reg = @"

    " 清理整个文件中的空白行
    g/^$/d

    " 获取选中区域内容
    normal! gv"ay

    " 将选中内容按行拆分，并删除空白行
    let l:lines = filter(split(@a, "\n"), { _, val -> trim(val) !=# '' })

    " 将选中内容按行拆分，并去掉换行符
    let l:lines = split(@a, "\n")

    " 为每行添加单引号，并用逗号连接
    let l:formatted = join(map(l:lines, { _, val -> "'".val."'" }), ",")

    " 在结果前后添加括号
    let l:result = "(" . l:formatted . ")"

    " 替换选中区域为格式化结果
    "normal! gvdi
    "call append('.', l:result)

    " 删除选中区域，并替换为格式化结果
    execute "normal! gvdi"
    call setline('.', l:result)
    " 清理整个文件中的空白行
    g/^$/d

    " 恢复之前的寄存器内容
    let @a = l:old_reg
endfunction

" 定义快捷键
xnoremap <silent> <leader>fl :<C-u>call FormatToList()<CR>
