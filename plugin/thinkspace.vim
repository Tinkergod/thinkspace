function! BreakUpContentBySenteces()
  execute ':%s/\v[ ]*([^\?]*\?)/\1\r/g'
  execute ':%s/\v[ ]*([^\.]*\.)/\1\r/g'
  execute ':%s/\v[ ]*([^\!]*\!)/\1\r/g'
endfunction

function! DetermineNumberOfSections()
  return number_of_sections
endfunction

function! CreatePartHeadings()
  let section_count=line('$')/10
  let parts=""
  let c=1
  while c <= section_count
    let parts=parts."# Part ".c."\n"."# End\n"
    let c=c+1
  endwhile
  let parts=parts."# Unsorted"
  execute ":normal! gg"
  execute ":normal! O" . parts
endfunction

function! MoveForwardAPart()
  execute ":/# Part"
endfunction

function! MoveBackwardApart()
  execute ":?# Part"
endfunction

function! MoveToPartX()
  call inputsave()
  let number=input("Enter part number: ")
  call inputrestore()
  execute ":norm dd"
  execute "/# Part ".number
  execute "/# End"
  execute ":norm P"
endfunction

function! CopyDeleteAllText()
  execute ":normal! gg"
  execute ":normal! dG"
endfunction
nnoremap <leader><Del> :call CopyDeleteAllText()<CR>

function! DeleteAllPartHeadings()
  execute ":g /^#.*/d"
endfunction

"TODO: make it so that if at the end of the file it can still manage to return to the end.
nmap <leader>=  :m -2<CR>
nmap <leader>-  :m +1<CR>
nmap <leader>_ :call BreakUpContentBySenteces()<CR> 
nmap <leader>h :call CreatePartHeadings()<CR>
nmap <leader>0 m':call MoveToPartX()<CR><C-O>z<CR>
nmap <leader>H :call DeleteAllPartHeadings()<CR>
