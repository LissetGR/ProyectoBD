PGDMP         ,                 {           Proyecto    15.1    15.1 <    p           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            q           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            r           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            s           1262    16398    Proyecto    DATABASE     l   CREATE DATABASE "Proyecto" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE "Proyecto";
                postgres    false            �            1259    17056    empleado    TABLE       CREATE TABLE public.empleado (
    id_empleado integer NOT NULL,
    id_empleado2 integer,
    fecha_contrato date,
    nombre_empleado text,
    edad integer,
    sexo text,
    horas_trabajo text,
    id_cine integer,
    id_sala integer,
    direccion text
);
    DROP TABLE public.empleado;
       public         heap    postgres    false            �            1255    24703    funcion1(text, integer)    FUNCTION     �  CREATE FUNCTION public.funcion1(cine text, anno integer) RETURNS SETOF public.empleado
    LANGUAGE plpgsql
    AS $_$
Declare 
empleado empleado%rowtype;
id_cineP integer;
Begin

Select into id_cineP Cine.id_cine from Cine where Cine.nombre_fantasia=$1;
if not found then
raise exception ' No se encontro el cine especificado';
end if;

for empleado in (Select * from Empleado 
				 where id_cine=id_cineP and Extract(year from fecha_contrato)<$2)
				 loop
				 return next empleado;
				 end loop;
End;
$_$;
 8   DROP FUNCTION public.funcion1(cine text, anno integer);
       public          postgres    false    220            �            1259    17025    pelicula    TABLE     �   CREATE TABLE public.pelicula (
    id_pelicula integer NOT NULL,
    duracion time without time zone,
    director text,
    genero text,
    titulo_original text,
    pais_origen text,
    id_director integer,
    info_actores text[]
);
    DROP TABLE public.pelicula;
       public         heap    postgres    false            �            1255    24697    funcion2(integer, text)    FUNCTION     :  CREATE FUNCTION public.funcion2(mes integer, actor text) RETURNS SETOF public.pelicula
    LANGUAGE plpgsql
    AS $_$
Declare
peliculas pelicula%rowtype;
Begin 

for peliculas in (Select distinct Pelicula.* from Pelicula inner join Proyeccion using (id_pelicula)
				 where $1 between Extract(month from proyeccion.fecha_inicio) and Extract(month from proyeccion.fecha_fin)
				 and id_pelicula in (Select distinct id_pelicula from Pelicula 
									 where $2= ANY(Pelicula.info_actores)		 
									)
				
				
				)loop
				return next peliculas;
end loop;
End
$_$;
 8   DROP FUNCTION public.funcion2(mes integer, actor text);
       public          postgres    false    216            �            1255    24773 +   funcion3(text, text, date, date, integer[])    FUNCTION       CREATE FUNCTION public.funcion3(titulo text, nombrecine text, fecha_incio date, fecha_fin date, id_personas integer[]) RETURNS void
    LANGUAGE plpgsql
    AS $_$
Declare 
id_pelicula integer;
id_cine integer;
tamanoA integer := array_length(id_personas,1);

Begin

Select into id_pelicula Pelicula.id_pelicula from Pelicula where Pelicula.titulo_original = $1;
if not found then
  raise exception 'Esa pelicula no se encuentra registrada';
end if;

Select into id_cine Cine.id_cine from Cine where Cine.nombre_fantasia = $2;
if not found then
  raise exception 'Esa pelicula no se encuentra registrada';
end if;

Insert into Proyeccion values(id_pelicula, id_cine, $3, $4);
 
for i in 1..tamanoA loop
  Insert into Proyeccion_persona values (i,id_pelicula, id_cine);
 
end loop;

end;
$_$;
 v   DROP FUNCTION public.funcion3(titulo text, nombrecine text, fecha_incio date, fecha_fin date, id_personas integer[]);
       public          postgres    false            �            1259    17008    actor    TABLE     �   CREATE TABLE public.actor (
    id_actor integer NOT NULL,
    genero_actor character(1),
    edad integer,
    nombre_actor text,
    nacionalidad text
);
    DROP TABLE public.actor;
       public         heap    postgres    false            �            1259    17037    cine    TABLE     �   CREATE TABLE public.cine (
    id_cine integer NOT NULL,
    nombre_fantasia text,
    barrio text,
    estado text,
    capacidad integer,
    municipio text,
    calle text,
    avenida text
);
    DROP TABLE public.cine;
       public         heap    postgres    false            �            1259    17080 
   proyeccion    TABLE     �   CREATE TABLE public.proyeccion (
    id_pelicula integer NOT NULL,
    id_cine integer NOT NULL,
    fecha_inicio date,
    fecha_fin date
);
    DROP TABLE public.proyeccion;
       public         heap    postgres    false            �            1259    17051    sala    TABLE     Y   CREATE TABLE public.sala (
    id_cine integer NOT NULL,
    id_sala integer NOT NULL
);
    DROP TABLE public.sala;
       public         heap    postgres    false            �            1259    24592 	   consulta1    VIEW     �  CREATE VIEW public.consulta1 AS
 SELECT empleado.id_empleado,
    empleado.id_empleado2,
    empleado.fecha_contrato,
    empleado.nombre_empleado,
    empleado.edad,
    empleado.sexo,
    empleado.horas_trabajo,
    empleado.id_cine,
    empleado.id_sala,
    empleado.direccion
   FROM (public.empleado
     JOIN public.cine USING (id_cine))
  WHERE ((empleado.id_cine IN ( SELECT cine_1.id_cine
           FROM (public.cine cine_1
             JOIN public.proyeccion USING (id_cine))
          WHERE (NOT (proyeccion.fecha_inicio > '2023-01-01'::date)))) AND (empleado.id_cine IN ( SELECT sala.id_cine
           FROM (public.sala
             JOIN public.cine cine_1 USING (id_cine))
          GROUP BY sala.id_cine
         HAVING (count(sala.id_sala) > 5))));
    DROP VIEW public.consulta1;
       public          postgres    false    217    219    219    220    220    220    220    220    220    220    220    220    220    221    221            �            1259    17090 
   extranjera    TABLE     ^   CREATE TABLE public.extranjera (
    id_pelicula integer NOT NULL,
    titulo_espanol text
);
    DROP TABLE public.extranjera;
       public         heap    postgres    false            �            1259    17044    persona    TABLE     b   CREATE TABLE public.persona (
    id_persona integer NOT NULL,
    edad integer,
    sexo text
);
    DROP TABLE public.persona;
       public         heap    postgres    false            �            1259    17085    proyeccion_persona    TABLE     �   CREATE TABLE public.proyeccion_persona (
    id_persona integer NOT NULL,
    id_pelicula integer NOT NULL,
    id_cine integer NOT NULL
);
 &   DROP TABLE public.proyeccion_persona;
       public         heap    postgres    false            �            1259    17119 	   consulta2    VIEW     }  CREATE VIEW public.consulta2 AS
 SELECT proyeccion.id_pelicula,
    proyeccion.id_cine,
    proyeccion.fecha_inicio,
    proyeccion.fecha_fin
   FROM (public.proyeccion
     JOIN public.extranjera USING (id_pelicula))
  WHERE ((proyeccion.fecha_inicio > '2022-12-31'::date) AND (proyeccion.id_cine IN ( SELECT proyeccion_persona.id_cine
           FROM (public.proyeccion_persona
             JOIN public.persona USING (id_persona))
          WHERE (proyeccion.id_pelicula IN ( SELECT proyeccion_persona_1.id_pelicula
                   FROM (public.proyeccion_persona proyeccion_persona_1
                     JOIN public.persona persona_1 USING (id_persona))
                  GROUP BY proyeccion_persona_1.id_pelicula
                  ORDER BY (count(*)) DESC
                 LIMIT 1))
          GROUP BY proyeccion_persona.id_cine
          ORDER BY (count(*)) DESC
         LIMIT 1)));
    DROP VIEW public.consulta2;
       public          postgres    false    222    222    222    221    221    221    221    218    223            �            1259    17124 	   consulta3    VIEW     �  CREATE VIEW public.consulta3 AS
 SELECT cine.barrio,
    cine.calle,
    cine.avenida,
    cine.municipio,
    cine.estado
   FROM (public.cine
     JOIN public.proyeccion USING (id_cine))
  WHERE ((proyeccion.fecha_inicio < '2023-01-01'::date) AND (proyeccion.id_pelicula IN ( SELECT proyeccion_1.id_pelicula
           FROM (public.proyeccion proyeccion_1
             JOIN public.extranjera USING (id_pelicula)))));
    DROP VIEW public.consulta3;
       public          postgres    false    217    217    217    217    217    217    221    221    221    223            �            1259    17015    director    TABLE     �   CREATE TABLE public.director (
    id_director integer NOT NULL,
    annos_experiencia integer,
    id_actor integer,
    nombre text,
    edad integer,
    nacionalidad text
);
    DROP TABLE public.director;
       public         heap    postgres    false            �            1259    24603 	   consulta4    VIEW     �  CREATE VIEW public.consulta4 AS
 SELECT DISTINCT director.nombre,
    director.edad,
    director.nacionalidad
   FROM ((public.director
     JOIN public.pelicula USING (id_director))
     JOIN public.proyeccion USING (id_pelicula))
  WHERE (proyeccion.id_cine IN ( SELECT cine.id_cine
           FROM (public.cine
             JOIN public.sala USING (id_cine))
          GROUP BY cine.id_cine
          ORDER BY (count(*)) DESC
         LIMIT 5));
    DROP VIEW public.consulta4;
       public          postgres    false    215    215    215    215    221    221    219    217    216    216            �            1259    24610    empleado_telefonos    TABLE     i   CREATE TABLE public.empleado_telefonos (
    id_empleado integer NOT NULL,
    telefono text NOT NULL
);
 &   DROP TABLE public.empleado_telefonos;
       public         heap    postgres    false            �            1259    24743 	   consulta5    VIEW     `  CREATE VIEW public.consulta5 AS
 SELECT empleado.nombre_empleado,
    empleado_telefonos.telefono
   FROM (public.empleado
     JOIN public.empleado_telefonos USING (id_empleado))
  WHERE ((empleado.id_sala IS NULL) AND (empleado.id_cine IN ( SELECT cine.id_cine
           FROM public.cine
          ORDER BY cine.capacidad DESC
         LIMIT 10)));
    DROP VIEW public.consulta5;
       public          postgres    false    220    220    220    220    230    217    217    230            �            1259    17142    empleado_funciones    TABLE     j   CREATE TABLE public.empleado_funciones (
    id_empleado integer NOT NULL,
    funciones text NOT NULL
);
 &   DROP TABLE public.empleado_funciones;
       public         heap    postgres    false            �            1259    17102    pelicula_actor    TABLE     h   CREATE TABLE public.pelicula_actor (
    id_pelicula integer NOT NULL,
    id_actor integer NOT NULL
);
 "   DROP TABLE public.pelicula_actor;
       public         heap    postgres    false            a          0    17008    actor 
   TABLE DATA           Y   COPY public.actor (id_actor, genero_actor, edad, nombre_actor, nacionalidad) FROM stdin;
    public          postgres    false    214   �X       d          0    17037    cine 
   TABLE DATA           n   COPY public.cine (id_cine, nombre_fantasia, barrio, estado, capacidad, municipio, calle, avenida) FROM stdin;
    public          postgres    false    217   pY       b          0    17015    director 
   TABLE DATA           h   COPY public.director (id_director, annos_experiencia, id_actor, nombre, edad, nacionalidad) FROM stdin;
    public          postgres    false    215   �Z       g          0    17056    empleado 
   TABLE DATA           �   COPY public.empleado (id_empleado, id_empleado2, fecha_contrato, nombre_empleado, edad, sexo, horas_trabajo, id_cine, id_sala, direccion) FROM stdin;
    public          postgres    false    220   [       l          0    17142    empleado_funciones 
   TABLE DATA           D   COPY public.empleado_funciones (id_empleado, funciones) FROM stdin;
    public          postgres    false    227   u\       m          0    24610    empleado_telefonos 
   TABLE DATA           C   COPY public.empleado_telefonos (id_empleado, telefono) FROM stdin;
    public          postgres    false    230   �\       j          0    17090 
   extranjera 
   TABLE DATA           A   COPY public.extranjera (id_pelicula, titulo_espanol) FROM stdin;
    public          postgres    false    223   B]       c          0    17025    pelicula 
   TABLE DATA           �   COPY public.pelicula (id_pelicula, duracion, director, genero, titulo_original, pais_origen, id_director, info_actores) FROM stdin;
    public          postgres    false    216   �]       k          0    17102    pelicula_actor 
   TABLE DATA           ?   COPY public.pelicula_actor (id_pelicula, id_actor) FROM stdin;
    public          postgres    false    224   _       e          0    17044    persona 
   TABLE DATA           9   COPY public.persona (id_persona, edad, sexo) FROM stdin;
    public          postgres    false    218   ]_       h          0    17080 
   proyeccion 
   TABLE DATA           S   COPY public.proyeccion (id_pelicula, id_cine, fecha_inicio, fecha_fin) FROM stdin;
    public          postgres    false    221   �_       i          0    17085    proyeccion_persona 
   TABLE DATA           N   COPY public.proyeccion_persona (id_persona, id_pelicula, id_cine) FROM stdin;
    public          postgres    false    222   !`       f          0    17051    sala 
   TABLE DATA           0   COPY public.sala (id_cine, id_sala) FROM stdin;
    public          postgres    false    219   t`       �           2606    17014    actor actor_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (id_actor);
 :   ALTER TABLE ONLY public.actor DROP CONSTRAINT actor_pkey;
       public            postgres    false    214            �           2606    17043    cine cine_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.cine
    ADD CONSTRAINT cine_pkey PRIMARY KEY (id_cine);
 8   ALTER TABLE ONLY public.cine DROP CONSTRAINT cine_pkey;
       public            postgres    false    217            �           2606    17019    director director_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_pkey PRIMARY KEY (id_director);
 @   ALTER TABLE ONLY public.director DROP CONSTRAINT director_pkey;
       public            postgres    false    215            �           2606    17062    empleado empleado_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (id_empleado);
 @   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_pkey;
       public            postgres    false    220            �           2606    24616 *   empleado_telefonos empleado_telefonos_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.empleado_telefonos
    ADD CONSTRAINT empleado_telefonos_pkey PRIMARY KEY (id_empleado, telefono);
 T   ALTER TABLE ONLY public.empleado_telefonos DROP CONSTRAINT empleado_telefonos_pkey;
       public            postgres    false    230    230            �           2606    17148 +   empleado_funciones empleados_funciones_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.empleado_funciones
    ADD CONSTRAINT empleados_funciones_pkey PRIMARY KEY (id_empleado, funciones);
 U   ALTER TABLE ONLY public.empleado_funciones DROP CONSTRAINT empleados_funciones_pkey;
       public            postgres    false    227    227            �           2606    17096    extranjera extranjera_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.extranjera
    ADD CONSTRAINT extranjera_pkey PRIMARY KEY (id_pelicula);
 D   ALTER TABLE ONLY public.extranjera DROP CONSTRAINT extranjera_pkey;
       public            postgres    false    223            �           2606    17106 "   pelicula_actor pelicula_actor_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.pelicula_actor
    ADD CONSTRAINT pelicula_actor_pkey PRIMARY KEY (id_pelicula, id_actor);
 L   ALTER TABLE ONLY public.pelicula_actor DROP CONSTRAINT pelicula_actor_pkey;
       public            postgres    false    224    224            �           2606    17031    pelicula pelicula_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT pelicula_pkey PRIMARY KEY (id_pelicula);
 @   ALTER TABLE ONLY public.pelicula DROP CONSTRAINT pelicula_pkey;
       public            postgres    false    216            �           2606    17050    persona persona_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (id_persona);
 >   ALTER TABLE ONLY public.persona DROP CONSTRAINT persona_pkey;
       public            postgres    false    218            �           2606    17089 *   proyeccion_persona proyeccion_persona_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.proyeccion_persona
    ADD CONSTRAINT proyeccion_persona_pkey PRIMARY KEY (id_persona, id_pelicula, id_cine);
 T   ALTER TABLE ONLY public.proyeccion_persona DROP CONSTRAINT proyeccion_persona_pkey;
       public            postgres    false    222    222    222            �           2606    17084    proyeccion proyeccion_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.proyeccion
    ADD CONSTRAINT proyeccion_pkey PRIMARY KEY (id_pelicula, id_cine);
 D   ALTER TABLE ONLY public.proyeccion DROP CONSTRAINT proyeccion_pkey;
       public            postgres    false    221    221            �           2606    17055    sala sala_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.sala
    ADD CONSTRAINT sala_pkey PRIMARY KEY (id_cine, id_sala);
 8   ALTER TABLE ONLY public.sala DROP CONSTRAINT sala_pkey;
       public            postgres    false    219    219            �           2606    17020    director director_id_actor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_id_actor_fkey FOREIGN KEY (id_actor) REFERENCES public.actor(id_actor);
 I   ALTER TABLE ONLY public.director DROP CONSTRAINT director_id_actor_fkey;
       public          postgres    false    3244    215    214            �           2606    17063 &   empleado empleado_id_cine_id_sala_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_id_cine_id_sala_fkey FOREIGN KEY (id_cine, id_sala) REFERENCES public.sala(id_cine, id_sala);
 P   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_id_cine_id_sala_fkey;
       public          postgres    false    219    220    3254    219    220            �           2606    17068 #   empleado empleado_id_empleado2_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_id_empleado2_fkey FOREIGN KEY (id_empleado2) REFERENCES public.empleado(id_empleado);
 M   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_id_empleado2_fkey;
       public          postgres    false    220    3256    220            �           2606    24617 6   empleado_telefonos empleado_telefonos_id_empleado_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.empleado_telefonos
    ADD CONSTRAINT empleado_telefonos_id_empleado_fkey FOREIGN KEY (id_empleado) REFERENCES public.empleado(id_empleado);
 `   ALTER TABLE ONLY public.empleado_telefonos DROP CONSTRAINT empleado_telefonos_id_empleado_fkey;
       public          postgres    false    220    230    3256            �           2606    17097 &   extranjera extranjera_id_pelicula_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.extranjera
    ADD CONSTRAINT extranjera_id_pelicula_fkey FOREIGN KEY (id_pelicula) REFERENCES public.pelicula(id_pelicula);
 P   ALTER TABLE ONLY public.extranjera DROP CONSTRAINT extranjera_id_pelicula_fkey;
       public          postgres    false    3248    223    216            �           2606    24774    pelicula_actor id_actor    FK CONSTRAINT     �   ALTER TABLE ONLY public.pelicula_actor
    ADD CONSTRAINT id_actor FOREIGN KEY (id_actor) REFERENCES public.actor(id_actor) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 A   ALTER TABLE ONLY public.pelicula_actor DROP CONSTRAINT id_actor;
       public          postgres    false    214    3244    224            �           2606    24779    pelicula_actor id_pelicula    FK CONSTRAINT     �   ALTER TABLE ONLY public.pelicula_actor
    ADD CONSTRAINT id_pelicula FOREIGN KEY (id_pelicula) REFERENCES public.pelicula(id_pelicula) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 D   ALTER TABLE ONLY public.pelicula_actor DROP CONSTRAINT id_pelicula;
       public          postgres    false    3248    216    224            �           2606    17032 "   pelicula pelicula_id_director_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT pelicula_id_director_fkey FOREIGN KEY (id_director) REFERENCES public.director(id_director);
 L   ALTER TABLE ONLY public.pelicula DROP CONSTRAINT pelicula_id_director_fkey;
       public          postgres    false    216    3246    215            �           2606    17107    sala sala_id_cine_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sala
    ADD CONSTRAINT sala_id_cine_fkey FOREIGN KEY (id_cine) REFERENCES public.cine(id_cine) NOT VALID;
 @   ALTER TABLE ONLY public.sala DROP CONSTRAINT sala_id_cine_fkey;
       public          postgres    false    3250    217    219            a   �   x�e�MN�0���S�		IS��[�!�Bb3m\1�����[!�Ћ�Ue����n���%{v#Z��`�"��p5�W������01�e�mO��'E1MaM�8JdAK$�Ӂ����4��B�A����g8ٞ�s�s������AY �i�Ar����L79��=�v�y�#/p������y��g
�<WMg���jI�N�͵�\��۔��Z�^c� ʲgu      d     x�]�]J�P��'��+��O}M#X���BA���;�+��$�ݍpݘ��V����s�3#*%��<Wn��G�Q�^�{V��bo��N��-���*��m�^h9H&��=|�Dk.�
��O��`Ph1ho�`mXh���b����7Ӥτ���Ho��]E0��v��l�h�zX"K�Y���&����+uV�r�M���s4�eÌ⫢�U˴�:4�s���B6�oJ�U���|�X�45����r������*I��~�      b   q   x�5�1�P���)�	�vd!�G�"HH����Sx1��75��'�y�4��C"]�12oVt�DC��D�t7�C�CYY��g�
k������14��,� I�#�      g   ]  x�U��N�0E���d;q����PP�H�Sb�EkKv�D7>�����c<�	ɛ}�A	�3!3���v/�E�=�#�܁T$(����K�|��q�JB�L�,�1!�'�_�
����G������7�a����,����h>�xҒ��dY��x쬏��<iE�
ӰC����ZX���Q�[,:������nCE�C���,/����`#��NH���p89�v~�?�SV	P���nMd��M�\���Ͻ	i�8|\�U�MU'RӲo��:se&�԰0��lTE�����>1|�q��X=��H�ô�L���pz� *5�Sp�=^3�~ � �      l   U   x�3�,K�+ITHIU(�L�N-)�2�tN-*J,2|2s2�,c�0��Ĝ�\ ;��˄�71�$5/373/�$��**����� �/      m   X   x���A��0�C�:rq�qX����Tw�C�<�/���k��f�
qLU+m��#>l��xl��ݶ:+^��wc�oXI����G�      j   J   x�3��IT�,�IT(���L-.)J�2���/V��K��rS�L9]sr��RR�sr�K�RSK�b���� �{`      c   s  x���͊A�s�)����$Q$�e�e��YW/5ӵ;��]��[P�a| �b_̚�+�������^��ݬ�n���4Q.[TI��V1��$�:�����:?�.�+�V�2_����T��:��4b�{x.���f���?s������_��,�*�'����aF;�T����iO���@��Jj�p����a"yF�L)#|�n�A�E����9��O��$�))Z�vs.��H���h�c׬��=jakh͔3ݓ� AzO�C�CQ��v������Z�/����r�Ge1�k��U�oA9RrW#���V%���v�mO���a���!0��?)r�������XK!�9��<L[�-n� ���ä�{4��~�2�f      k   .   x���	  �w�1z'؋��a��������ͅeNv�*m� >�qB      e   ,   x�3�42���2�46�t�2�44R���f@ʄ��(���� u��      h   x   x�E�A!B��.�A���.��9����@D��Esxt����3��D���W2��tޒ�z�Cl�?��t��Vǟ����i#�ܹ��9�@R�Q��;��X@�@����2�?��,      i   C   x�-���@Cѳ]L$�U������	}	!)�c	1ш�g�u���6�����k���X����� �AY      f   <   x���  �7.)')���`�cdˉ-�-���3����Bk�����{�($�� �
�     