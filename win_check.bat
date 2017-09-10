@echo off
if exist  %~d1%~p1work (
    echo work lib exists. Do not create.
) else (
    echo Creating work lib ...
    vlib work
)

vlog -lint -work work %1
if errorlevel 1 (
    exit
)

echo
echo
echo Searching --do vsim-- switch in %1.

find /c "--do vsim--" %1
if errorlevel 1 (
    echo --do vsim-- is not enabled, do not run vsim.
    exit
)
echo
echo --do vsim-- is enabled, run vsim ...
echo
vsim -c work.%~n1 -do "run 200ns;quit"
exit
