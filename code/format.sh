files=`ls *.{h,c,cpp}`

echo $files

for file in $files ; do
	clang-format -i -style="{BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 72}" $file ;
done
