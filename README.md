![image](https://github.com/marcoalonso/CoinGekoiOS/assets/49013250/d1b03a02-cc0f-45dd-a05a-a5dc2b8151cd)

![image](https://github.com/marcoalonso/CoinGekoiOS/assets/49013250/873d1c96-5c46-41f5-9e65-3ec1348f9e29)


La capa de data depende de la capa de dominio, respetando la regla de la dependencia. La capa de Dominio NO sabe nada con respecto a la capa de data. 

Se crea una interfaz de la cual dependerá el caso de uso, dicha interfaz será implementada por un componente que pertenece a una capa exterior.

El caso de uso podrá utilizar todo lo que se encuentra en la capa de Data sin conocer ningun detalle al respecto.

![image](https://github.com/marcoalonso/CoinGekoiOS/assets/49013250/513311bc-efa1-4362-b49d-0d35e887547a)

