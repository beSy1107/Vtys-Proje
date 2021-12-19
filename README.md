2021 GÜZ DÖNEMİ

DERS : VERİ TABANI ve YÖNETİM SİSTEMLERİ

DR. ÖĞR. ÜYESİ İSMAİL ÖZTEL

PROJE : POSTGRESQL KULLANARAK UYGULAMA GELİŞTİRİLMESİ

HAZIRLAYAN

ADI : MUHAMMED EMİN
SOYADI : ÇETİN

ÖĞRENCİ NUMARASI : B201210077

E-MAİL : muhammed.cetin9@ogr.sakarya.edu.tr

SINIF : 1.Öğretim B Grubu





Projenin tanıtımı

Kullanıcıların üye olarak kullanacakları bir platform tasarlanmıştır. Platformun içerisinde iki ayrı kategori oluşturulmuştur: film kategorileri ve genel kategoriler. Film kategorilerine film - dizi eklenebilir, eklenenlere yorum yapılabilir ve genel kategorideki alanlara göre bir mesaj ya da soru paylaşımı yapılabilir ve sorular için cevap da verilebilir. Buna ek olarak kullanıcılar tavsiye edilen gezilecek yerleri görüp kendileride tavsiyede bulunabilir ve burçlar kısmında güncel yorumları paylaşıp paylaşılanları da görüntüleyebilir.

İş Kuralları

Her kullanıcı üye olmak ve “Name, Surname, Username, Password” bilgilerini girmek zorundadır.
Üye olan kullanıcılar paylaşılan mesajları, soruları, cevapları, tavsiyeleri ve yorumları görüntüleyebilecek ve bunlara ekleme yapabilecektir.
Her kullanıcı eklediği veriden puan elde edecektir. Puan hesaplaması şu şekilde olacaktır:
Mesaj, 10 puan; soru, 8 puan; cevap, 15 puan; film - dizi tavsiyesi, 15 puan, film-dizi yorumu, 5 puan; burç yorumu, 5 puan; gezilecek yer tavsiyesi, 8 puan.

Puanına göre her kullanıcının bir rank’ı olacaktır. Rank hesaplaması şu şekildedir :
2000’den az ise “Soldier”;
2000-10000 ise “Sergeant”;
10000-100000 ise “Lieutenant”;
100000-1000000 ise “Colonel”;
1000000 ‘dan fazla ise “General”;

Kullanıcıların ranklarının hesaplanabilmesi için platformun her alanında en az bir ekleme yapılmış olması gerekmektedir.


İlişkisel Şema


Varlık Bağıntı Modeli


Veritabanı SQL İfadeleri (sayfa 73’e kadar)

Sql ifadelerinin bulunduğu link:

https://github.com/beSy1107/Vtys-Proje/blob/1f5108db9ec564909c3863f7059baadafd1600ac/vtys_proje.sql


Saklı yordam ve Tetikleyiciler


Procedures :

addnewhreply : Burçlara yorum ekleme
begin
insert into horoscopereplies(horoscopeid,hrcontent,userid) values (horoscopeid,hrcontent,userid);
end;
addnewmessage : Mesaj ekleme
begin
insert into messages(mcontent,userid,categoryid) values (mcontent,userid,categoryid);
end;
addnewmovie : Film ekleme
insert into movies (moviename,movietopic,catid,userid) values (moviename,movietopic,catid,userid);
addnewplace : Yer tavsiyesi ekleme
begin
insert into places (placename,content,citycode,countrycode,userid) values (placename,content,citycode,countrycode,userid);
end;
addnewquestion : Soru ekleme
begin
insert into questions(qcontent,userid,categoryid) values (qcontent,userid,categoryid);
end;
addnewreply : Soruya cevap ekleme
begin
insert into replies(rcontent,questionid,userid) values (rcontent,questionid,userid);
end;
addnewserie : Dizi önerme
insert into series (seriename,serietopic,catid,userid) values (seriename,serietopic,catid,userid);
addnewuser : Kullanıcı kaydetme
begin
insert into users(username,password,name,surname) values (username,password,name,surname);
end;
mreply : Filme yorum yapma
begin
insert into moviereplies (movieid,userid,content) values (movieid,userid,content);
end;


sreply : Diziye yorum yapma
begin
insert into seriereplies (serieid,userid,content) values (serieid,userid,content);
end;



Functions:

points: Eklenen verilere göre toplam puanın hesaplanması

begin
messages:=messages*10;
hreplies:=hreplies*5;
mreplies:=mreplies*5;
movies:=movies*15;
places:=places*8;
questions:=questions*8;
replies:=replies*15;
sreplies:=sreplies*5;
series:=series*15;
return messages+hreplies+mreplies+movies+places+questions+replies+sreplies+series;
end;

Trigger Functions - Trigger:

renew() : Her veri girişinden sonra puan tablosunun güncel kalması için trigger function.
begin
perform * from points;
return new;
end;
renewtrig : 9 tablo için ayrı 9 tane renewtrig bulunmakta. bu trigger renew fonksiyonunu tablolara yapılan işleminden sonra tetikliyor ve puanların güncel kalmasını sağlıyor.
sysrank() : Bu trigger fonksiyonu rankların sistemini içeriyor.
BEGIN
update users set rankid=case
when users.points<2000 then 1
when users.points between 2001 and 10000 then 2
when users.points between 10001 and 100000 then 3
when users.points between 100001 and 1000000 then 4
when 1000001<users.points then 5
end; return new; END;
ranktrigg : Bu isimde 9 trigger var, 9 tabloyada her veri girişinden sonra sysrank fonksiyonunu tetikliyor.
addpointstousers() : Bu trigger fonksiyonu points view’indeki hesaplanmış puanları ana kullanıcı tablosu olan users’a aktarır.

ranktrig : Bu trigger yine 9 tablo için 9 farklı ekleme işleminde yazılmıştır. Puanlar her güncellendiğinde addpointsusers() fonksiyonunu çalıştırır ve puanların users tablosuna aktarılmasını sağlar.


Arama Ekleme Güncelleme

Bu bölüm videoda da bulunmakta.

Güncelleme : Program arayüzünde güncelleme bulunmamakta fakat veritabanında triggerlar ile puanlar sürekli güncellenmekte.
Ekleme : Örnek olarak mesaj ve soru ekleme bölümü

Arama : Kullanıcı arama kısmı uygulama içinde bulunmaktadır.



Uygulama Kaynak Kodları

Bulunduğu link

https://github.com/beSy1107/Vtys-Proje

Çalışmamı Anlattığım Video

https://youtu.be/QnXgMpbjTxM
