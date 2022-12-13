######################################################################
# Instituto Nacional de Pesca y Acuacultura                          #
# Código para relizar Gráficas de Frecuencias de tallas.             #
#Fecha de creación: 20/03/2018
#Autor: Romero Fernández Odín Erik
#
#Última vez revisado y corregido:13/12/2022
#
#
#####################################################################


        png(filename= paste0("I:/R especies 2017/tablas e imágenes/",especie,"_",crucer,".jpg"),width = 2100,height = 2100,res=300)######se activa el guardado en formato jpg
#
par(mai= c(1, 1, 1, 1),xpd=TRUE,xlog=FALSE,ylog=FALSE)
#tot_re<-filter(tab2,total>0)
barplot(tab4$totales,xlab="Longitud total (cm)", 
    ylab="Frecuencia (núm de org.)", col="cadetblue3",las=1,
    names.arg= tab4$niveles,axes=TRUE,axis.lty = 1)#"cadetblue3"
par(new = T)
plot(tab4$acumulado,axes="FALSE",xlab="",ylab="",type="l",lty=2,lwd=3)  
axis(side=4,yaxp=c(0,100,5),col="black",las=1)
title(main=especie,font.main=3,cex.main =1.6 ) 
mtext("Frecuencia acumulada (%)", side = 4, line = 2.5,col="black")

# mtext("Frecuencia acumulada (%)",side=4,line=3.2)
par(fig = c(0,1,0,1), oma = c(0, 0, 0, 0), mar = c(0, 0, 3, 0), new = TRUE)
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")
legend("top","Frecuencia acumulada",pch=150,col="black",bty="n")

dev.off()

write.csv(tab4,paste0("I:/R especies 2017/tablas e imágenes/",especie,"_",crucer,".csv"),row.names=F)
rm(list=ls(all=TRUE))
}