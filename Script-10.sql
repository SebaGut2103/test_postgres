create table if not exists cliente(
		id serial primary key,
		cedula varchar(20) unique  not null,
		nombre varchar(50) not null,
		contacto varchar(10) not null,
		direccion text,
		check(length(cedula)>6),
		check(length(contacto)=10)
);

create table if not exists Pelicula(
	id serial primary key,
	titulo varchar(100)not null,
	director varchar(50)not null,
	año int,
	precio decimal(10,2) not null
);

create table if not exists Sucursal(
	id serial primary key,
	ubicacion varchar(100) not null
);

create type categoria_peli  as enum('Terror', 'Accion',
	'Drama', 'Romance', 'Comedia');

create table if not exists Categoria(
	id_peli int,
	categoria categoria_peli not null,
	primary key(id_peli),
	foreign key(id_peli) references Pelicula(id)
);


create type disponibilidad_peli as enum('Si', 'No');
create table if not exists Disponibilidad(
	id_sucursal int,
	id_peli int,
	diposnibilidad disponibilidad_peli not null,
	foreign key(id_sucursal) references Sucursal(id),
	foreign key(id_peli) references Pelicula(id)
);

create table if not exists Alquiler(
	id serial primary key,
	id_peli int,
	id_cliente int,
	fecha_ini date not null,
	fecha_dev date not null,
	precio decimal(10,2) not null,
	foreign key(id_peli) references Pelicula(id),
	foreign key(id_cliente) references Cliente(id)
);


insert into Cliente(cedula,nombre,contacto,direccion) values
(100529815, 'Sebastian', '3003554331', 'Minuto de dios t-17 apto-102'); --1
('108954182', 'Stefanya', '3003455890', 'Kennedy-cra10-cll2'), --2
('100587902', 'Fercho', '3164452119', 'Giron-cra10-cll7'), --3
('100587903', 'Lorenzo', '3164452118', 'V.Rosa-cra10-cll7'), --4
('100587904', 'Eric', '3164452120', 'Giron-cra10-cll20'), --5
('100587905', 'Tetsu', '3164452121', 'Centro-cra98-cll21'), --6
('100587906', 'Elisabeth', '3164452122', 'Giron-cra20-cll22'), --7
('100587907', 'Juan', '3164452123', 'Giron-cra10-cll23'), --8
('100587908', 'Jimmi', '3164452124', 'Giron-cra10-cll7'),--9
('100587909', 'Camila', '3164452125', 'Giron-cra20-cll7'); --10
insert into Pelicula(titulo,director, año, precio) values
1	('spiderman-2',	'Sam Raimi,'	2004,	2.10)
2	('Star Wars episodio IV',	'George Lucas',	1977	5.00)
3	(El señor de los anillos el retorno del rey	Peter Jackson	2003	5.00)
4	(Club de la Pelea	David Flinch	1999	5.00)
5	(Taxi Driver	Martin Scorsses	1976	3.00)
6	(La Naranja Mecanica	Stanley Kubrick	1974	3.00)
7	(El Padrino	Francis Ford Coppola	1972	4.12)
8	(Jurassic Park	Steven Spilberg	1992	2.10)
9	(Full Metal Jacker	Stanley Kubrick	1984	4.12)
10	(Hellboy	Guillermo del Toro	2004	4.12)
11	(Nosequecolocar	SebaGut	2024	3.55)
12	(Terminator 2 el Juicio Final	James Cameron	1992	2.10)
13	(El Pianista	Roman Polansky	2002	5.00)
14	(Godzilla	Nomecuerdo	1954	2.00)
15	(Matrix	Las Hermanas Wachosky	1999	3.12);

-- Consulta
select s.ubicacion as Sucursal, sum(p.precio)
from sucursal s 
join disponibilidad d on s.id = d.id_sucursal 
join pelicula p on d.id_peli = p.id 
join alquiler a on p.id = a.id_peli 
where  (
	select data_part('month', a2.fecha_ini)
	from alquiler a2 
) = '05'
group by s.id;
