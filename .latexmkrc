$ENV{'PATH'} = "/Applications/Inkscape.app/Contents/MacOS:$ENV{'PATH'}";
$pdflatex = 'pdflatex -interaction=nonstopmode -shell-escape %O %S';
$pdf_mode = 1;

# After a successful build, check for a <jobname>.outputname file written by
# \thesissetup{outputname=...} and copy the PDF to that name.
# %R is substituted by latexmk with the root filename (e.g. "main").
$success_cmd = q{sh -c 'f=$(cat %R.outputname 2>/dev/null); test -n "$f" && test -f %R.pdf && cp %R.pdf "${f}.pdf" && echo "Latexmk: output copied to ${f}.pdf"'};
