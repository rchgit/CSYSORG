.model small
.stack 100h
.data

asc_dat1 db '5734207891'
asc_dat2 db '0075143824'

.code
main proc far
mov ax,@data
mov ds, ax
mov es, ax

lea bp, asc_dat1
