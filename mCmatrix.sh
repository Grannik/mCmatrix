#!/bin/bash
 E='echo -e';
 e='echo -en';
#
 i=0; CLEAR; CIVIS;NULL=/dev/null
 trap "R;exit" 2
 ESC=$( $e "\e")
 TPUT(){ $e "\e[${1};${2}H" ;}
 CLEAR(){ $e "\ec";}
 CIVIS(){ $e "\e[?25l";}
 R(){ CLEAR ;stty sane;CLEAR;};                 # в этом варианте фон прозрачный
#
 ARROW(){ IFS= read -s -n1 key 2>/dev/null >&2
           if [[ $key = $ESC ]];then
              read -s -n1 key 2>/dev/null >&2;
              if [[ $key = \[ ]]; then
                 read -s -n1 key 2>/dev/null >&2;
                 if [[ $key = A ]]; then echo up;fi
                 if [[ $key = B ]];then echo dn;fi
              fi
           fi
           if [[ "$key" == "$($e \\x0A)" ]];then echo enter;fi;}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ma="\e[47;30m│\e[0m                                                                                \e[47;30m│\e[0m"
 mb="\033[0m\033[47;30m┌────────────────────────────────────────────────────────────────────────────────┐\033[0m"
 mc="\e[47;30m├\e[0m\e[1;30m────────────────────────────────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m"
 md="\e[47;30m├\e[0m\e[2m─ Up \xE2\x86\x91 \xE2\x86\x93 Down Select Enter ─────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m"
 me="\033[0m\033[47;30m└────────────────────────────────────────────────────────────────────────────────┘\033[0m"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 UNMARK(){ $e "\e[0m";}
 MARK(){ $e "\e[30;47m";}
#
 HEAD()
{
 for (( a=2; a<=38; a++ ))
          do
              TPUT $a 1;$E "$ma"
          done
TPUT  1 1;$E "$mb"
TPUT  3 3;$E "\e[1;36m*** CMatrix ***\e[0m\e[36m simulates the display from \"The Matrix\"\e[0m";
TPUT  4 1;$E "$mc"
TPUT 10 1;$E "\e[47;30m├\e[0m\e[1;30m─ Option ────────────────────────────────────────────────────────────── Опции ──\e[0m\e[47;30m┤\e[0m";
TPUT 25 1;$E "\e[47;30m├\e[0m\e[1;30m─ Keystrokes ───────────────────────────────────────────────── Нажатия клавиш ──\e[0m\e[47;30m┤\e[0m";
TPUT 26 3;$E "\e[30m Во время выполнения доступны сочетания клавиш, недоступные в режиме -s\e[0m";
TPUT 34 1;$E "$mc"
TPUT 35 3;$E "\e[30m Up ↑ ↓ Down Select Enter\e[0m"
}
 FOOT(){ MARK;TPUT 39 1;$E "$me";UNMARK;}
#
  M0(){ TPUT  5 3; $e "\
 Установка                                                          \
\e[32m Install \e[0m";}
  M1(){ TPUT  6 3; $e "\
 Kраткий обзор                                                     \
\e[32m Synopsis \e[0m";}
  M2(){ TPUT  7 3; $e "\
 Описание                                                       \
\e[32m Description \e[0m";}
  M3(){ TPUT  8 3; $e "\
 Bugs                                                                \
\e[32m Ошибки \e[0m";}
  M4(){ TPUT  9 3; $e "\
 Домашняя страница                                                 \
\e[32m Homepage \e[0m";}
#
  M5(){ TPUT 11 3; $e "\
 Асинхронная прокрутка                                                   \
\e[32m -a \e[0m";}
  M6(){ TPUT 12 3; $e "\
 Жирные символы на                                                       \
\e[32m -b \e[0m";}
  M7(){ TPUT 13 3; $e "\
 Все жирные символы (переопределяет -b)                                  \
\e[32m -B \e[0m";}
  M8(){ TPUT 14 3; $e "\
 Принудительно включить тип linux \$TERM                                  \
\e[32m -f \e[0m";}
  M9(){ TPUT 15 3; $e "\
 Режим Linux (устанавливает шрифт «matrix.fnt» в консоли)                \
\e[32m -l \e[0m";}
 M10(){ TPUT 16 3; $e "\
 Используйте прокрутку в старом стиле                                    \
\e[32m -o \e[0m";}
 M11(){ TPUT 17 3; $e "\
 Print usage and exit                                                \
\e[32m -h, -? \e[0m";}
 M12(){ TPUT 18 3; $e "\
 Без жирного шрифта (переопределяет -b и -B)                             \
\e[32m -n \e[0m";}
 M13(){ TPUT 19 3; $e "\
 Режим «Скринсейвер», выход при первом нажатии клавиши                   \
\e[32m -s \e[0m";}
 M14(){ TPUT 20 3; $e "\
 Режим «лямбда», каждый символ становится лямбда                         \
\e[32m -m \e[0m";}
 M15(){ TPUT 21 3; $e "\
 Режим окна X, используйте, если ваш xterm использует mtx.pcf            \
\e[32m -x \e[0m";}
 M16(){ TPUT 22 3; $e "\
 Print version information and exit                                      \
\e[32m -V \e[0m";}
 M17(){ TPUT 23 3; $e "\
 Screen update delay 0 - 9, default 4                              \
\e[32m -u delay \e[0m";}
 M18(){ TPUT 24 3; $e "\
 Use this color for matrix (default green)                         \
\e[32m -C color \e[0m";}
#
 M19(){ TPUT 27 3; $e "\
 Включить асинхронную прокрутку                                           \
\e[32m a \e[0m";}
 M20(){ TPUT 28 3; $e "\
 Случайные полужирные символы                                             \
\e[32m b \e[0m";}
 M21(){ TPUT 29 3; $e "\
 Все жирные символы                                                       \
\e[32m B \e[0m";}
 M22(){ TPUT 30 3; $e "\
 Отключить жирный шрифт                                                   \
\e[32m n \e[0m";}
 M23(){ TPUT 31 3; $e "\
 Отрегулируйте скорость обновления                                      \
\e[32m 0-9 \e[0m";}
 M24(){ TPUT 32 3; $e "\
 Измените цвет матрицы на соответствующий цвет             \
\e[32m ! @ \# \$ % ^ & ) \e[0m";}
 M25(){ TPUT 33 3; $e "\
 Quit the program                                                         \
\e[32m q \e[0m";}
#
 M26(){ TPUT 36 3; $e "\
 Grannik Git                                                                 ";}
 M27(){ TPUT 37 3; $e "\
 Exit                                                                        ";}
LM=27
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
# Функция возвращения в меню
     ES(){ MARK;$e " ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
  0) S=M0;SC; if [[ $cur == enter ]];then R;echo -e "\e[32m sudo apt install\e[0m";ES;fi;;
  1) S=M1;SC; if [[ $cur == enter ]];then R;echo -e "\e[32m
 cmatrix [-abBflohnsmVx] [-u update] [-C color]
\e[0m";ES;fi;;
  2) S=M2;SC; if [[ $cur == enter ]];then R;echo -e "
 Shows a scrolling 'Matrix' like screen in Linux
";ES;fi;;
  3) S=M3;SC; if [[ $cur == enter ]];then R;echo -e "
 Эта программа очень интенсивно использует процессор.
 Не удивляйтесь, если время от времени он потребляет более 40% вашего процессора.
";ES;fi;;
  4) S=M4;SC; if [[ $cur == enter ]];then R;echo -e "\e[36m
 http://www.github.com/abishekvashok/cmatrix
\e[0m";ES;fi;;
  5) S=M5;SC; if [[ $cur == enter ]];then R;echo -e "\e[32m cmatrix -a\e[0m";ES;fi;;
  6) S=M6;SC; if [[ $cur == enter ]];then R;echo -e "\e[32m cmatrix -b\e[0m";ES;fi;;
  7) S=M7;SC; if [[ $cur == enter ]];then R;echo -e "\e[32m cmatrix -B\e[0m";ES;fi;;
  8) S=M8;SC; if [[ $cur == enter ]];then R;echo -e "\e[32m cmatrix -f\e[0m";ES;fi;;
  9) S=M9;SC; if [[ $cur == enter ]];then R;echo -e "\e[32m cmatrix -l\e[0m";ES;fi;;
 10) S=M10;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m cmatrix -o\e[0m";ES;fi;;
 11) S=M11;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m
 cmatrix -h
 cmatrix -?
\e[0m";ES;fi;;
 12) S=M12;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m cmatrix -n\e[0m";ES;fi;;
 13) S=M13;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m cmatrix -s\e[0m";ES;fi;;
 14) S=M14;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m cmatrix -m\e[0m";ES;fi;;
 15) S=M15;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m cmatrix -x\e[0m";ES;fi;;
 16) S=M16;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m cmatrix -V\e[0m";ES;fi;;
 17) S=M17;SC;if [[ $cur == enter ]];then R;echo -e "
 Screen update delay 0 - 9, default 4
\e[32m cmatrix -u\e[0m
";ES;fi;;
 18) S=M18;SC;if [[ $cur == enter ]];then R;echo -e "
 Use this color for matrix (default green).
 Valid colors are:
 green, red, blue, white, yellow, cyan, magenta, black
\e[32m cmatrix -C\e[0m";ES;fi;;
 19) S=M19;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m cmatrix -\e[0m";ES;fi;;
#
 20) S=M20;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m \e[0m";ES;fi;;
 21) S=M21;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m \e[0m";ES;fi;;
 22) S=M22;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m \e[0m";ES;fi;;
 23) S=M23;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m \e[0m";ES;fi;;
 24) S=M24;SC;if [[ $cur == enter ]];then R;echo -e "
 Измените цвет матрицы на соответствующий цвет:
\e[32m !\e[0m red
\e[32m @\e[0m green
\e[32m #\e[0m yellow
\e[32m \$\e[0m blue
\e[32m %\e[0m magenta
\e[32m ^\e[0m cyan
\e[32m &\e[0m white
\e[32m )\e[0m black.
";ES;fi;;
 25) S=M25;SC;if [[ $cur == enter ]];then R;echo -e "\e[32m \e[0m";ES;fi;;
#
 26) S=M26;SC;if [[ $cur == enter ]];then R;echo -e "
 Di 12 Jul 2022 16:42:14 CEST

 a - asciinema     file asciinema файл
 c - circular menu file общее меню
 s - source        file источник
 t - text          file текстовый файл
 l - bash list     file лист
 m - menu          file меню
 n - simple menu   file простое меню

 mCmatrix
 Описанме утилиты cmatrix, имитируежей дисплей из «Матрицы».

 Asciinema:  \e[36m https://asciinema.org/a/539041\e[0m
 Github:     \e[36m \e[0m
 Gitlab:     \e[36m \e[0m
 Sourceforge:\e[36m \e[0m
 Notabug:    \e[36m \e[0m
 Codeberg:   \e[36m \e[0m
 Bitbucket:  \e[36m \e[0m
 Framagit:   \e[36m \e[0m
 Gitea:      \e[36m \e[0m
 GFogs: The owner has reached maximum creation limit of 10 repositories.
";ES;fi;;
 27) S=M27;SC;if [[ $cur == enter ]];then R;clear;ls -l;exit 0;fi;;
 esac;POS;done
