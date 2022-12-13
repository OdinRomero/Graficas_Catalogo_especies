######################################################################
# Instituto Nacional de Pesca y Acuacultura                          #
# Código para relizar Gráficas de Frecuencias de tallas.             #
#Fecha de creación: 20/03/2018
#Autor: Romero Fernández Odín Erik
#
#Última vez revisado y corregido:16/07/2018
#
#
#####################################################################

#################################Librerías usadas ###################
#install.packages("dplyr")
#install.packages("FSA")
#################################para cargarlas #####################
library(dplyr)
library(FSA)

###### Área de datos a ingresar!!!!!########
num<-95
for(i in 1:num){
	lista<-read.csv2("SP.csv")
	especie<-paste(lista$sp[i])  
########AQUI PONES EL NOMBRE DE LA ESPECIE..
########Aqui pones cuantos lances se realizaron.
crucer<-"JCFINP06_11"      ###### Aquí que crucero es 
######################Cuerpo del script#######

tab<-read.csv2(paste0(especie,".csv"))
corte<-which(tab$Frecuencia>0)#para obtener las líneas donde no hay cero

Frecuencia<-tab$Frecuencia[min(corte):max(corte)]
Talla<-tab$clase[min(corte):max(corte)]
tab2<-data.frame(Talla,Frecuencia)
tamaño<-length(Talla)
#######Aquí insertar el if######

#inter<-tamaño/10
if ( tamaño>89) {inter<-tamaño/20
}else {if ( tamaño>49) {inter<-tamaño/15
 }else {if ( tamaño>10) {inter<-tamaño/10
  }else {inter<-tamaño}
       }
}###los corchetes van pegados a los else si no no los corre R
inter<-round(inter, digits = 0); inter
if(tamaño>15){tab3<-mutate(tab2,Inter.clase=lencat(Talla,as.fact=T,w=inter ))
   }else{tab3<-mutate(tab2,Inter.clase=lencat(Talla,as.fact=T ))}
#obtienen los intervalos de clsae con lencat pag:52
totales<-tapply(tab3$Frecuencia,tab3$Inter.clase,sum)
niveles<-levels(tab3$Inter.clase)
tab4<-data.frame(niveles,totales)
# 
#tab2<-tab%>%mutate_all(funs(replace(., is.na(.), 0))) ###Aquí se cambian los N/A por ceros.

 tot<-sum(tab4$totales)  #se saca el total
tab4<-mutate(tab4,porcentaje=(tab4$totales*100)/tot)#mutate es para hacer operaciones dentro de un dataframe, y crea una nueva columna con el resultado
tab4$acumulado<-cumsum(tab4$porcentaje)
tab4$niveles<-factor(tab4$niveles, levels=tab4$niveles)
###########  Sección de graficado     #################
#n<-18  ###poner el rango 
        png(filename= paste0("I:/R especies 2017/tablas e imágenes/",especie,"_",crucer,".jpg"),width = 2100,height = 2100,res=300)######se activa el guardado en formato jpg
#
par(mai= c(1, 1, 1, 1),xpd=TRUE,xlog=FALSE,ylog=FALSE)
#tot_re<-filter(tab2,total>0)
barplot(tab4$totales,xlab="Longitud total (cm)", 
ylab="Frecuencia (núm de org.)", col="cadetblue3",las=1,
names.arg= tab4$niveles,axes=TRUE,axis.lty = 1)#"cadetblue3"
par(new = T)
plot(tab4$acumulado,axes="FALSE",xlab="",ylab="",type="l",lty=2,lwd=3)  #,
axis(side=4,yaxp=c(0,100,5),col="black",las=1)
title(main=especie,font.main=3,cex.main =1.6 ) 
mtext("Frecuencia acumulada (%)", side = 4, line = 2.5,col="black")

# mtext("Frecuencia acumulada (%)",side=4,line=3.2)
par(fig = c(0,1,0,1), oma = c(0, 0, 0, 0), mar = c(0, 0, 3, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")
	  legend("top","Frecuencia acumulada",pch=150,
col="black",bty="n")

dev.off()

write.csv(tab4,paste0("I:/R especies 2017/tablas e imágenes/",especie,"_",crucer,".csv"),row.names=F)
rm(list=ls(all=TRUE))
}