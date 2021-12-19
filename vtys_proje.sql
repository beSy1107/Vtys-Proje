--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: addnewhreply(integer, text, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.addnewhreply(IN horoscopeid integer, IN hrcontent text, IN userid integer)
    LANGUAGE plpgsql
    AS $$
begin
insert into horoscopereplies(horoscopeid,hrcontent,userid) values (horoscopeid,hrcontent,userid);
end;
$$;


ALTER PROCEDURE public.addnewhreply(IN horoscopeid integer, IN hrcontent text, IN userid integer) OWNER TO postgres;

--
-- Name: addnewmessage(text, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.addnewmessage(IN mcontent text, IN userid integer, IN categoryid integer)
    LANGUAGE plpgsql
    AS $$
begin
insert into messages(mcontent,userid,categoryid) values (mcontent,userid,categoryid);
end;
$$;


ALTER PROCEDURE public.addnewmessage(IN mcontent text, IN userid integer, IN categoryid integer) OWNER TO postgres;

--
-- Name: addnewmovie(text, text, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.addnewmovie(IN moviename text, IN movietopic text, IN catid integer, IN userid integer)
    LANGUAGE sql
    AS $$
insert into movies (moviename,movietopic,catid,userid) values (moviename,movietopic,catid,userid);
$$;


ALTER PROCEDURE public.addnewmovie(IN moviename text, IN movietopic text, IN catid integer, IN userid integer) OWNER TO postgres;

--
-- Name: addnewplace(text, text, integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.addnewplace(IN placename text, IN content text, IN citycode integer, IN countrycode integer, IN userid integer)
    LANGUAGE plpgsql
    AS $$
begin
insert into places (placename,content,citycode,countrycode,userid) values (placename,content,citycode,countrycode,userid);
end;
$$;


ALTER PROCEDURE public.addnewplace(IN placename text, IN content text, IN citycode integer, IN countrycode integer, IN userid integer) OWNER TO postgres;

--
-- Name: addnewquestion(text, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.addnewquestion(IN qcontent text, IN userid integer, IN categoryid integer)
    LANGUAGE plpgsql
    AS $$
begin
insert into questions(qcontent,userid,categoryid) values (qcontent,userid,categoryid);
end;
$$;


ALTER PROCEDURE public.addnewquestion(IN qcontent text, IN userid integer, IN categoryid integer) OWNER TO postgres;

--
-- Name: addnewreply(text, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.addnewreply(IN rcontent text, IN questionid integer, IN userid integer)
    LANGUAGE plpgsql
    AS $$
begin
insert into replies(rcontent,questionid,userid) values (rcontent,questionid,userid);
end;
$$;


ALTER PROCEDURE public.addnewreply(IN rcontent text, IN questionid integer, IN userid integer) OWNER TO postgres;

--
-- Name: addnewserie(text, text, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.addnewserie(IN seriename text, IN serietopic text, IN catid integer, IN userid integer)
    LANGUAGE sql
    AS $$
insert into series (seriename,serietopic,catid,userid) values (seriename,serietopic,catid,userid);
$$;


ALTER PROCEDURE public.addnewserie(IN seriename text, IN serietopic text, IN catid integer, IN userid integer) OWNER TO postgres;

--
-- Name: addnewuser(character varying, character varying, text, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.addnewuser(IN username character varying, IN password character varying, IN name text, IN surname text)
    LANGUAGE plpgsql
    AS $$
begin
insert into users(username,password,name,surname) values (username,password,name,surname);
end;
$$;


ALTER PROCEDURE public.addnewuser(IN username character varying, IN password character varying, IN name text, IN surname text) OWNER TO postgres;

--
-- Name: addpointstousers(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.addpointstousers() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

update users set points=(select points from points where  points.userid=users.userid);

return new;
END;
$$;


ALTER FUNCTION public.addpointstousers() OWNER TO postgres;

--
-- Name: mreply(integer, integer, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.mreply(IN movieid integer, IN userid integer, IN content text)
    LANGUAGE plpgsql
    AS $$
begin
insert into moviereplies (movieid,userid,content) values (movieid,userid,content);
end;
$$;


ALTER PROCEDURE public.mreply(IN movieid integer, IN userid integer, IN content text) OWNER TO postgres;

--
-- Name: points(bigint, bigint, bigint, bigint, bigint, bigint, bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.points(messages bigint, hreplies bigint, mreplies bigint, movies bigint, places bigint, questions bigint, replies bigint, sreplies bigint, series bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.points(messages bigint, hreplies bigint, mreplies bigint, movies bigint, places bigint, questions bigint, replies bigint, sreplies bigint, series bigint) OWNER TO postgres;

--
-- Name: renew(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.renew() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
perform * from points;
return new;
end;
$$;


ALTER FUNCTION public.renew() OWNER TO postgres;

--
-- Name: sreply(integer, integer, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.sreply(IN serieid integer, IN userid integer, IN content text)
    LANGUAGE plpgsql
    AS $$
begin
insert into seriereplies (serieid,userid,content) values (serieid,userid,content);
end;
$$;


ALTER PROCEDURE public.sreply(IN serieid integer, IN userid integer, IN content text) OWNER TO postgres;

--
-- Name: sysrank(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sysrank() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

update users set rankid=case
						when users.points<2000 then 1
						when users.points between 2001 and 10000 then 2
						when users.points between 10001 and 100000 then 3
						when users.points between 100001 and 1000000 then 4
						when 1000001<users.points then 5
						end;

return new;
END;
$$;


ALTER FUNCTION public.sysrank() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: horoscopereplies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.horoscopereplies (
    hreplieid integer NOT NULL,
    horoscopeid integer NOT NULL,
    hrcontent text NOT NULL,
    userid integer NOT NULL
);


ALTER TABLE public.horoscopereplies OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    messageid integer NOT NULL,
    mcontent text NOT NULL,
    userid integer NOT NULL,
    categoryid integer NOT NULL
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: moviereplies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.moviereplies (
    mreplieid integer NOT NULL,
    movieid integer NOT NULL,
    userid integer NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.moviereplies OWNER TO postgres;

--
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    movieid integer NOT NULL,
    moviename text NOT NULL,
    movietopic text NOT NULL,
    catid integer NOT NULL,
    userid integer NOT NULL
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- Name: places; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.places (
    placeid integer NOT NULL,
    placename text NOT NULL,
    citycode integer NOT NULL,
    countrycode integer NOT NULL,
    content text NOT NULL,
    userid integer NOT NULL
);


ALTER TABLE public.places OWNER TO postgres;

--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    questionid integer NOT NULL,
    qcontent text NOT NULL,
    userid integer NOT NULL,
    categoryid integer NOT NULL
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: replies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.replies (
    replyid integer NOT NULL,
    rcontent text NOT NULL,
    questionid integer NOT NULL,
    userid integer NOT NULL
);


ALTER TABLE public.replies OWNER TO postgres;

--
-- Name: seriereplies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seriereplies (
    sreplieid integer NOT NULL,
    serieid integer NOT NULL,
    userid integer NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.seriereplies OWNER TO postgres;

--
-- Name: series; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.series (
    serieid integer NOT NULL,
    seriename text NOT NULL,
    serietopic text NOT NULL,
    catid integer NOT NULL,
    userid integer NOT NULL
);


ALTER TABLE public.series OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    username character varying(20) NOT NULL,
    password character varying(20) NOT NULL,
    name text NOT NULL,
    surname text NOT NULL,
    rankid integer DEFAULT 1,
    points integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: view1; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view1 AS
 SELECT messages.userid,
    count(*) AS messages
   FROM public.messages
  GROUP BY messages.userid;


ALTER TABLE public.view1 OWNER TO postgres;

--
-- Name: step1; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.step1 AS
 SELECT users.userid,
    view1.messages
   FROM (public.users
     FULL JOIN public.view1 ON ((users.userid = view1.userid)));


ALTER TABLE public.step1 OWNER TO postgres;

--
-- Name: view2; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view2 AS
 SELECT horoscopereplies.userid,
    count(*) AS hreplies
   FROM public.horoscopereplies
  GROUP BY horoscopereplies.userid;


ALTER TABLE public.view2 OWNER TO postgres;

--
-- Name: step2; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.step2 AS
 SELECT step1.userid,
    step1.messages,
    view2.hreplies
   FROM (public.step1
     FULL JOIN public.view2 ON ((step1.userid = view2.userid)));


ALTER TABLE public.step2 OWNER TO postgres;

--
-- Name: view3; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view3 AS
 SELECT moviereplies.userid,
    count(*) AS mreplies
   FROM public.moviereplies
  GROUP BY moviereplies.userid;


ALTER TABLE public.view3 OWNER TO postgres;

--
-- Name: step3; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.step3 AS
 SELECT step2.userid,
    step2.messages,
    step2.hreplies,
    view3.mreplies
   FROM (public.step2
     FULL JOIN public.view3 ON ((step2.userid = view3.userid)));


ALTER TABLE public.step3 OWNER TO postgres;

--
-- Name: view4; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view4 AS
 SELECT movies.userid,
    count(*) AS movies
   FROM public.movies
  GROUP BY movies.userid;


ALTER TABLE public.view4 OWNER TO postgres;

--
-- Name: step4; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.step4 AS
 SELECT step3.userid,
    step3.messages,
    step3.hreplies,
    step3.mreplies,
    view4.movies
   FROM (public.step3
     FULL JOIN public.view4 ON ((step3.userid = view4.userid)));


ALTER TABLE public.step4 OWNER TO postgres;

--
-- Name: view5; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view5 AS
 SELECT places.userid,
    count(*) AS places
   FROM public.places
  GROUP BY places.userid;


ALTER TABLE public.view5 OWNER TO postgres;

--
-- Name: step5; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.step5 AS
 SELECT step4.userid,
    step4.messages,
    step4.hreplies,
    step4.mreplies,
    step4.movies,
    view5.places
   FROM (public.step4
     FULL JOIN public.view5 ON ((step4.userid = view5.userid)));


ALTER TABLE public.step5 OWNER TO postgres;

--
-- Name: view6; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view6 AS
 SELECT questions.userid,
    count(*) AS questions
   FROM public.questions
  GROUP BY questions.userid;


ALTER TABLE public.view6 OWNER TO postgres;

--
-- Name: step6; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.step6 AS
 SELECT step5.userid,
    step5.messages,
    step5.hreplies,
    step5.mreplies,
    step5.movies,
    step5.places,
    view6.questions
   FROM (public.step5
     FULL JOIN public.view6 ON ((step5.userid = view6.userid)));


ALTER TABLE public.step6 OWNER TO postgres;

--
-- Name: view7; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view7 AS
 SELECT replies.userid,
    count(*) AS replies
   FROM public.replies
  GROUP BY replies.userid;


ALTER TABLE public.view7 OWNER TO postgres;

--
-- Name: step7; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.step7 AS
 SELECT step6.userid,
    step6.messages,
    step6.hreplies,
    step6.mreplies,
    step6.movies,
    step6.places,
    step6.questions,
    view7.replies
   FROM (public.step6
     FULL JOIN public.view7 ON ((step6.userid = view7.userid)));


ALTER TABLE public.step7 OWNER TO postgres;

--
-- Name: view8; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view8 AS
 SELECT seriereplies.userid,
    count(*) AS sreplies
   FROM public.seriereplies
  GROUP BY seriereplies.userid;


ALTER TABLE public.view8 OWNER TO postgres;

--
-- Name: step8; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.step8 AS
 SELECT step7.userid,
    step7.messages,
    step7.hreplies,
    step7.mreplies,
    step7.movies,
    step7.places,
    step7.questions,
    step7.replies,
    view8.sreplies
   FROM (public.step7
     FULL JOIN public.view8 ON ((step7.userid = view8.userid)));


ALTER TABLE public.step8 OWNER TO postgres;

--
-- Name: view9; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view9 AS
 SELECT series.userid,
    count(*) AS series
   FROM public.series
  GROUP BY series.userid;


ALTER TABLE public.view9 OWNER TO postgres;

--
-- Name: allofpoints; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.allofpoints AS
 SELECT step8.userid,
    step8.messages,
    step8.hreplies,
    step8.mreplies,
    step8.movies,
    step8.places,
    step8.questions,
    step8.replies,
    step8.sreplies,
    view9.series
   FROM (public.step8
     FULL JOIN public.view9 ON ((step8.userid = view9.userid)));


ALTER TABLE public.allofpoints OWNER TO postgres;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    categoryid integer NOT NULL,
    categoryname text NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_categoryid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_categoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_categoryid_seq OWNER TO postgres;

--
-- Name: categories_categoryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_categoryid_seq OWNED BY public.categories.categoryid;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    citycode integer NOT NULL,
    cityname text NOT NULL,
    countrycode integer NOT NULL
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    countrycode integer NOT NULL,
    countryname text NOT NULL
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: filmcategories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.filmcategories (
    catid integer NOT NULL,
    catname text NOT NULL
);


ALTER TABLE public.filmcategories OWNER TO postgres;

--
-- Name: filmcategories_catid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.filmcategories_catid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filmcategories_catid_seq OWNER TO postgres;

--
-- Name: filmcategories_catid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.filmcategories_catid_seq OWNED BY public.filmcategories.catid;


--
-- Name: points; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.points AS
 SELECT allofpoints.userid,
    allofpoints.messages,
    allofpoints.hreplies,
    allofpoints.mreplies,
    allofpoints.movies,
    allofpoints.places,
    allofpoints.questions,
    allofpoints.replies,
    allofpoints.sreplies,
    allofpoints.series,
    public.points(allofpoints.messages, allofpoints.hreplies, allofpoints.mreplies, allofpoints.movies, allofpoints.places, allofpoints.questions, allofpoints.replies, allofpoints.sreplies, allofpoints.series) AS points
   FROM public.allofpoints;


ALTER TABLE public.points OWNER TO postgres;

--
-- Name: rank; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rank (
    rankid integer NOT NULL,
    rankname text NOT NULL
);


ALTER TABLE public.rank OWNER TO postgres;

--
-- Name: viewrank; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.viewrank AS
 SELECT users.userid,
    users.username,
    users.name,
    users.surname,
    users.rankid,
    rank.rankname
   FROM (public.users
     FULL JOIN public.rank ON ((users.rankid = rank.rankid)));


ALTER TABLE public.viewrank OWNER TO postgres;

--
-- Name: general; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.general AS
 SELECT points.userid,
    points.messages,
    points.hreplies,
    points.mreplies,
    points.movies,
    points.places,
    points.questions,
    points.replies,
    points.sreplies,
    points.series,
    viewrank.username,
    viewrank.name,
    viewrank.surname,
    viewrank.rankname
   FROM (public.points
     FULL JOIN public.viewrank ON ((points.userid = viewrank.userid)));


ALTER TABLE public.general OWNER TO postgres;

--
-- Name: getmessage; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.getmessage AS
 SELECT messages.messageid,
    messages.mcontent,
    messages.userid,
    messages.categoryid,
    users.username
   FROM (public.messages
     LEFT JOIN public.users ON ((users.userid = messages.userid)));


ALTER TABLE public.getmessage OWNER TO postgres;

--
-- Name: getquestion; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.getquestion AS
 SELECT questions.questionid,
    questions.qcontent,
    questions.userid,
    questions.categoryid,
    users.username
   FROM (public.questions
     LEFT JOIN public.users ON ((users.userid = questions.userid)));


ALTER TABLE public.getquestion OWNER TO postgres;

--
-- Name: getreply; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.getreply AS
 SELECT replies.questionid,
    replies.replyid,
    replies.rcontent,
    replies.userid,
    users.username
   FROM (public.replies
     LEFT JOIN public.users ON ((users.userid = replies.userid)));


ALTER TABLE public.getreply OWNER TO postgres;

--
-- Name: horoscopefeatures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.horoscopefeatures (
    featuresid integer NOT NULL,
    horoscopeid integer NOT NULL,
    featurecontent text NOT NULL
);


ALTER TABLE public.horoscopefeatures OWNER TO postgres;

--
-- Name: horoscopefeatures_featuresid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.horoscopefeatures_featuresid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.horoscopefeatures_featuresid_seq OWNER TO postgres;

--
-- Name: horoscopefeatures_featuresid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.horoscopefeatures_featuresid_seq OWNED BY public.horoscopefeatures.featuresid;


--
-- Name: horoscopereplies_hreplieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.horoscopereplies_hreplieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.horoscopereplies_hreplieid_seq OWNER TO postgres;

--
-- Name: horoscopereplies_hreplieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.horoscopereplies_hreplieid_seq OWNED BY public.horoscopereplies.hreplieid;


--
-- Name: horoscopes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.horoscopes (
    horoscopeid integer NOT NULL,
    horoscopename text NOT NULL
);


ALTER TABLE public.horoscopes OWNER TO postgres;

--
-- Name: horoscopes_horoscopeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.horoscopes_horoscopeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.horoscopes_horoscopeid_seq OWNER TO postgres;

--
-- Name: horoscopes_horoscopeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.horoscopes_horoscopeid_seq OWNED BY public.horoscopes.horoscopeid;


--
-- Name: hreplies; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.hreplies AS
 SELECT horoscopereplies.hreplieid,
    horoscopereplies.horoscopeid,
    horoscopereplies.hrcontent,
    horoscopereplies.userid,
    users.username
   FROM (public.horoscopereplies
     LEFT JOIN public.users ON ((users.userid = horoscopereplies.userid)));


ALTER TABLE public.hreplies OWNER TO postgres;

--
-- Name: messages_messageid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_messageid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_messageid_seq OWNER TO postgres;

--
-- Name: messages_messageid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_messageid_seq OWNED BY public.messages.messageid;


--
-- Name: moviereplies_mreplieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.moviereplies_mreplieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moviereplies_mreplieid_seq OWNER TO postgres;

--
-- Name: moviereplies_mreplieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.moviereplies_mreplieid_seq OWNED BY public.moviereplies.mreplieid;


--
-- Name: movies_movieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_movieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movies_movieid_seq OWNER TO postgres;

--
-- Name: movies_movieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_movieid_seq OWNED BY public.movies.movieid;


--
-- Name: moviestable; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.moviestable AS
 SELECT filmcategories.catid,
    filmcategories.catname,
    movies.movieid,
    movies.moviename,
    movies.movietopic,
    movies.userid
   FROM (public.filmcategories
     FULL JOIN public.movies ON ((movies.catid = filmcategories.catid)));


ALTER TABLE public.moviestable OWNER TO postgres;

--
-- Name: moviestable2; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.moviestable2 AS
 SELECT moviestable.catid,
    moviestable.moviename,
    moviestable.movietopic,
    moviestable.userid,
    moviestable.catname,
    users.username
   FROM (public.moviestable
     LEFT JOIN public.users ON ((moviestable.userid = users.userid)));


ALTER TABLE public.moviestable2 OWNER TO postgres;

--
-- Name: mreplies; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.mreplies AS
 SELECT moviereplies.mreplieid,
    moviereplies.movieid,
    moviereplies.userid,
    users.username,
    moviereplies.content
   FROM (public.moviereplies
     LEFT JOIN public.users ON ((users.userid = moviereplies.userid)));


ALTER TABLE public.mreplies OWNER TO postgres;

--
-- Name: places_placeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.places_placeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.places_placeid_seq OWNER TO postgres;

--
-- Name: places_placeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.places_placeid_seq OWNED BY public.places.placeid;


--
-- Name: placess; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.placess AS
 SELECT places.placeid,
    places.placename,
    places.citycode,
    places.countrycode,
    places.content,
    places.userid,
    users.username
   FROM (public.places
     LEFT JOIN public.users ON ((users.userid = places.userid)));


ALTER TABLE public.placess OWNER TO postgres;

--
-- Name: questions_questionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_questionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_questionid_seq OWNER TO postgres;

--
-- Name: questions_questionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_questionid_seq OWNED BY public.questions.questionid;


--
-- Name: rank_rankid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rank_rankid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rank_rankid_seq OWNER TO postgres;

--
-- Name: rank_rankid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rank_rankid_seq OWNED BY public.rank.rankid;


--
-- Name: replies_replyid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.replies_replyid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.replies_replyid_seq OWNER TO postgres;

--
-- Name: replies_replyid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.replies_replyid_seq OWNED BY public.replies.replyid;


--
-- Name: seriereplies_sreplieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seriereplies_sreplieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seriereplies_sreplieid_seq OWNER TO postgres;

--
-- Name: seriereplies_sreplieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seriereplies_sreplieid_seq OWNED BY public.seriereplies.sreplieid;


--
-- Name: series_serieid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.series_serieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_serieid_seq OWNER TO postgres;

--
-- Name: series_serieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.series_serieid_seq OWNED BY public.series.serieid;


--
-- Name: seriestable; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.seriestable AS
 SELECT filmcategories.catid,
    filmcategories.catname,
    series.seriename,
    series.serietopic,
    series.userid
   FROM (public.series
     FULL JOIN public.filmcategories ON ((filmcategories.catid = series.catid)));


ALTER TABLE public.seriestable OWNER TO postgres;

--
-- Name: seriestable2; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.seriestable2 AS
 SELECT seriestable.catid,
    seriestable.catname,
    seriestable.seriename,
    seriestable.serietopic,
    seriestable.userid,
    users.username
   FROM (public.seriestable
     LEFT JOIN public.users ON ((users.userid = seriestable.userid)));


ALTER TABLE public.seriestable2 OWNER TO postgres;

--
-- Name: sreplies; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.sreplies AS
 SELECT seriereplies.sreplieid,
    seriereplies.serieid,
    seriereplies.userid,
    users.username,
    seriereplies.content
   FROM (public.seriereplies
     LEFT JOIN public.users ON ((users.userid = seriereplies.userid)));


ALTER TABLE public.sreplies OWNER TO postgres;

--
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_userid_seq OWNER TO postgres;

--
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- Name: categories categoryid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN categoryid SET DEFAULT nextval('public.categories_categoryid_seq'::regclass);


--
-- Name: filmcategories catid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filmcategories ALTER COLUMN catid SET DEFAULT nextval('public.filmcategories_catid_seq'::regclass);


--
-- Name: horoscopefeatures featuresid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horoscopefeatures ALTER COLUMN featuresid SET DEFAULT nextval('public.horoscopefeatures_featuresid_seq'::regclass);


--
-- Name: horoscopereplies hreplieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horoscopereplies ALTER COLUMN hreplieid SET DEFAULT nextval('public.horoscopereplies_hreplieid_seq'::regclass);


--
-- Name: horoscopes horoscopeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horoscopes ALTER COLUMN horoscopeid SET DEFAULT nextval('public.horoscopes_horoscopeid_seq'::regclass);


--
-- Name: messages messageid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN messageid SET DEFAULT nextval('public.messages_messageid_seq'::regclass);


--
-- Name: moviereplies mreplieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moviereplies ALTER COLUMN mreplieid SET DEFAULT nextval('public.moviereplies_mreplieid_seq'::regclass);


--
-- Name: movies movieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies ALTER COLUMN movieid SET DEFAULT nextval('public.movies_movieid_seq'::regclass);


--
-- Name: places placeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places ALTER COLUMN placeid SET DEFAULT nextval('public.places_placeid_seq'::regclass);


--
-- Name: questions questionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN questionid SET DEFAULT nextval('public.questions_questionid_seq'::regclass);


--
-- Name: rank rankid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rank ALTER COLUMN rankid SET DEFAULT nextval('public.rank_rankid_seq'::regclass);


--
-- Name: replies replyid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.replies ALTER COLUMN replyid SET DEFAULT nextval('public.replies_replyid_seq'::regclass);


--
-- Name: seriereplies sreplieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seriereplies ALTER COLUMN sreplieid SET DEFAULT nextval('public.seriereplies_sreplieid_seq'::regclass);


--
-- Name: series serieid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series ALTER COLUMN serieid SET DEFAULT nextval('public.series_serieid_seq'::regclass);


--
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories VALUES
	(1, 'Love'),
	(2, 'Life'),
	(3, 'Sport'),
	(4, 'Economy'),
	(5, 'Lessons'),
	(6, 'University'),
	(7, 'General');


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cities VALUES
	(34, 'Istanbul', 90),
	(22, 'Edirne', 90),
	(35, 'Izmir', 90),
	(50, 'Nevsehir', 90),
	(98, 'Berlin', 4),
	(109, 'Munchen', 4),
	(107, 'Koln', 4),
	(82, 'Roma', 5),
	(77, 'Milano', 5),
	(78, 'Napoli', 5),
	(71, 'Londra', 6),
	(66, 'Barcelona', 11),
	(118, 'Madrid', 11),
	(110, 'New York', 400),
	(67, 'California', 400),
	(84, 'Tokyo', 732);


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.countries VALUES
	(400, 'United States'),
	(4, 'Germany'),
	(6, 'United Kingdom'),
	(11, 'Spain'),
	(5, 'Italy'),
	(732, 'Japan'),
	(90, 'Turkey');


--
-- Data for Name: filmcategories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.filmcategories VALUES
	(1, 'Animation'),
	(2, 'Action'),
	(3, 'Comedy'),
	(4, 'Drama'),
	(5, 'Fantasy'),
	(6, 'Horror'),
	(7, 'Mystery'),
	(8, 'Romance'),
	(9, 'Thriller'),
	(10, 'Western'),
	(11, 'Science Fiction');


--
-- Data for Name: horoscopefeatures; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.horoscopefeatures VALUES
	(1, 1, 'The first sign of the zodiac, Aries loves to be number one. Naturally, this dynamic fire sign is no stranger to competition. Bold and ambitious, Aries dives headfirst into even the most challenging situations—and they will make sure they always come out on top!'),
	(2, 2, 'What sign is more likely to take a six-hour bath, followed by a luxurious Swedish massage and decadent dessert spread? Why Taurus, of course! Taurus is an earth sign represented by the bull. Like their celestial spirit animal, Taureans enjoy relaxing in serene, bucolic environments surrounded by soft sounds, soothing aromas, and succulent flavors.'),
	(3, 3, 'Have you ever been so busy that you wished you could clone yourself just to get everything done? That s the Gemini experience in a nutshell. Spontaneous, playful, and adorably erratic, Gemini is driven by its insatiable curiosity. Appropriately symbolized by the celestial twins, this air sign was interested in so many pursuits that it had to double itself. You know, NBD!'),
	(4, 4, 'Represented by the crab, Cancer seamlessly weaves between the sea and shore representing Cancer’s ability to exist in both emotional and material realms. Cancers are highly intuitive and their psychic abilities manifest in tangible spaces. But—just like the hard-shelled crustaceans—this water sign is willing to do whatever it takes to protect itself emotionally. In order to get to know this sign, you re going to need to establish trust!'),
	(5, 5, 'Roll out the red carpet because Leo has arrived. Passionate, loyal, and infamously dramatic, Leo is represented by the lion and these spirited fire signs are the kings and queens of the celestial jungle. They re delighted to embrace their royal status: Vivacious, theatrical, and fiery, Leos love to bask in the spotlight and celebrate… well, themselves. '),
	(6, 6, 'You know the expression, "if you want something done, give it to a busy person?" Well, that definitely is the Virgo anthem. Virgos are logical, practical, and systematic in their approach to life. Virgo is an earth sign historically represented by the goddess of wheat and agriculture, an association that speaks to Virgo s deep-rooted presence in the material world. This earth sign is a perfectionist at heart and isn’t afraid to improve skills through diligent and consistent practice.'),
	(7, 7, 'Balance, harmony, and justice define Libra energy. As a cardinal air sign, Libra is represented by the scales (interestingly, the only inanimate object of the zodiac), an association that reflects Libra s fixation on establishing equilibrium. Libra is obsessed with symmetry and strives to create equilibrium in all areas of life — especially when it comes to matters of the heart.'),
	(8, 8, 'Elusive and mysterious, Scorpio is one of the most misunderstood signs of the zodiac. Scorpio is a water sign that uses emotional energy as fuel, cultivating powerful wisdom through both the physical and unseen realms. In fact, Scorpio derives its extraordinary courage from its psychic abilities, which is what makes this sign one of the most complicated, dynamic signs of the zodiac.'),
	(9, 9, 'Oh, the places Sagittarius goes! But… actually. This fire sign knows no bounds. Represented by the archer, Sagittarians are always on a quest for knowledge. The last fire sign of the zodiac, Sagittarius launches its many pursuits like blazing arrows, chasing after geographical, intellectual, and spiritual adventures.'),
	(10, 10, 'What is the most valuable resource? For Capricorn, the answer is clear: Time. Capricorn is climbing the mountain straight to the top and knows that patience, perseverance, and dedication is the only way to scale. The last earth sign of the zodiac, Capricorn, is represented by the sea-goat, a mythological creature with the body of a goat and the tail of a fish. Accordingly, Capricorns are skilled at navigating both the material and emotional realms.'),
	(11, 11, 'Despite the "aqua" in its name, Aquarius is actually the last air sign of the zodiac. Innovative, progressive, and shamelessly revolutionary, Aquarius is represented by the water bearer, the mystical healer who bestows water, or life, upon the land. Accordingly, Aquarius is the most humanitarian astrological sign. At the end of the day, Aquarius is dedicated to making the world a better place.'),
	(12, 12, 'If you looked up the word "psychic" in the dictionary, there would definitely be a picture of Pisces next to it. Pisces is the most intuitive, sensitive, and empathetic sign of the entire zodiac — and that’s because it’s the last of the last. As the final sign, Pisces has absorbed every lesson — the joys and the pain, the hopes and the fears — learned by all of the other signs. It is symbolized by two fish swimming in opposite directions, representing the constant division of Pisces attention between fantasy and reality.');


--
-- Data for Name: horoscopereplies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.horoscopereplies VALUES
	(11, 1, 'Çok umursamaz ve eğlenceye düşkünler.', 33),
	(12, 1, 'Bu ay bu burcu çok güzel şeyler bekliyor', 32),
	(13, 1, 'En sevmediğim burçlardan biri', 35),
	(14, 1, 'Bu yılım berbat geçti. Bu burcu ben seçmedim halbuki. Ne bahtsız burcumuz varmış. :(', 34);


--
-- Data for Name: horoscopes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.horoscopes VALUES
	(1, 'Aries'),
	(2, 'Taurus'),
	(3, 'Gemini'),
	(4, 'Cancer'),
	(5, 'Leo'),
	(6, 'Virgo'),
	(7, 'Libra'),
	(8, 'Scorpio'),
	(9, 'Sagittarius'),
	(10, 'Capricorn'),
	(11, 'Aquarius'),
	(12, 'Pisces');


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.messages VALUES
	(45, 'Verme beni ellere görürde dayanamazsın gülüm.', 35, 1),
	(46, 'Keşke platform türkçe olsaymış. Kullananlar türk ama platform ingilizce. :)', 32, 7),
	(47, 'Bu dolar kimin cebine dolar.', 32, 4),
	(48, 'Kenetlenmişsin kalbime ilmek ilmek işlenmişsin yüreğime. Nereye böyle bileyim söyle. #dolar', 33, 4),
	(49, '#dolar an itibariyle 16. Sene sonuna kadar 18 i geçecek mi?', 32, 4),
	(50, 'Geçen ay aldığım 3 e aldığım bu ay 5 olmuş. Yazık ... #dolar $$$', 34, 4),
	(51, 'Aşk acısı çekiyorum aaaaaşşşkkk.', 34, 1),
	(52, 'Arkadaşlar yazıyorum yazıyorum bitmiyor bu kod.', 32, 5);


--
-- Data for Name: moviereplies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.moviereplies VALUES
	(43, 6, 32, 'Çok beğenerek izledim'),
	(44, 6, 34, 'Gerçekten çok güzel'),
	(45, 6, 33, 'Mükemmel'),
	(46, 6, 35, 'Herkes izlemeli'),
	(47, 7, 35, 'Kesinlikle tavsiye ediyorum'),
	(48, 7, 34, 'Adamlar yapıyor.'),
	(49, 7, 33, 'Tek kelimeyle mükemmel.'),
	(50, 8, 33, 'Soluksuz izledim diyebilirim'),
	(51, 8, 34, 'Çok güzeldi. Herkese tavsiye ederim.'),
	(52, 8, 32, 'Beğenerek izledik.'),
	(53, 8, 35, 'En sevdiğiiimmmm.'),
	(54, 9, 31, 'Defalarca izlenir.'),
	(55, 9, 32, 'Hiç sıkılmadan tek solukta izlenir.'),
	(56, 10, 31, 'Oldukça güzel bir film olmuş.'),
	(57, 10, 35, 'Biz çok beğendik.');


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.movies VALUES
	(6, 'The Shawshank Redemption', 'The Shawshank Redemption is a 1994 American drama film written and directed by Frank Darabont, based on the 1982 Stephen King novella Rita Hayworth and Shawshank Redemption. It tells the story of banker Andy Dufresne (Tim Robbins), who is sentenced to life in Shawshank State Penitentiary for the murders of his wife and her lover, despite his claims of innocence. Over the following two decades, he befriends a fellow prisoner, contraband smuggler Ellis "Red" Redding (Morgan Freeman), and becomes instrumental in a money-laundering operation led by the prison warden Samuel Norton (Bob Gunton). William Sadler, Clancy Brown, Gil Bellows, and James Whitmore appear in supporting roles.

Darabont purchased the film rights to King''s story in 1987, but development did not begin until five years later, when he wrote the script over an eight-week period. Two weeks after submitting his script to Castle Rock Entertainment, Darabont secured a $25 million budget to produce The Shawshank Redemption, which started pre-production in January 1993. While the film is set in Maine, principal photography took place from June to August 1993 almost entirely in Mansfield, Ohio, with the Ohio State Reformatory serving as the eponymous penitentiary. The project attracted many stars of the time for the role of Andy, including Tom Hanks, Tom Cruise, and Kevin Costner. Thomas Newman provided the film''s score.

While The Shawshank Redemption received critical acclaim on its release, particularly for its story and the performances of Robbins and Freeman, it was a box-office disappointment, earning only $16 million during its initial theatrical run. Many reasons were cited for its failure at the time, including competition from films such as Pulp Fiction and Forrest Gump, the general unpopularity of prison films, its lack of female characters, and even the title, which was considered to be confusing for audiences. It went on to receive multiple award nominations, including seven Academy Award nominations, and a theatrical re-release that, combined with international takings, increased the film''s box-office gross to $58.3 million.

Over 320,000 VHS rental copies were shipped throughout the United States, and on the strength of its award nominations and word of mouth, it became one of the top video rentals of 1995. The broadcast rights were acquired following the purchase of Castle Rock by Turner Broadcasting System, and it was shown regularly on the TNT network starting in 1997, further increasing its popularity. Decades after its release, the film was still broadcast regularly, and is popular in several countries, with audience members and celebrities citing it as a source of inspiration, and naming the film as a favorite in various surveys. In 2015, the United States Library of Congress selected the film for preservation in the National Film Registry, finding it "culturally, historically, or aesthetically significant".', 4, 32),
	(7, 'The Godfather', 'The Godfather is a 1972 American crime film directed by Francis Ford Coppola, who co-wrote the screenplay with Mario Puzo, based on Puzo''s best-selling 1969 novel of the same name. The film stars Marlon Brando, Al Pacino, James Caan, Richard Castellano, Robert Duvall, Sterling Hayden, John Marley, Richard Conte, and Diane Keaton. It is the first installment in The Godfather trilogy. The story, spanning from 1945 to 1955, chronicles the Corleone family under patriarch Vito Corleone (Brando), focusing on the transformation of his youngest son, Michael Corleone (Pacino), from reluctant family outsider to ruthless mafia boss.

Paramount Pictures obtained the rights to the novel for the price of $80,000, before it gained popularity.[2][3] Studio executives had trouble finding a director; the first few candidates turned down the position before Coppola signed on to direct the film but disagreement followed over casting several characters, in particular, Vito and Michael. Filming took place primarily on location around New York City and in Sicily, and was completed ahead of schedule. The musical score was composed principally by Nino Rota, with additional pieces by Carmine Coppola.

The Godfather premiered at the Loew''s State Theatre on March 14, 1972, and was widely released in the United States on March 24, 1972. It was the highest-grossing film of 1972,[4] and was for a time the highest-grossing film ever made,[3] earning between $246 and $287 million at the box office. The film received universal acclaim from critics and audiences, with praise for the performances, particularly those of Brando and Pacino, the directing, screenplay, cinematography, editing, score, and portrayal of the mafia. The Godfather acted as a catalyst for the successful careers of Coppola, Pacino, and other relative newcomers in the cast and crew. The film also revitalized Brando''s career, which had declined in the 1960s, and he went on to star in films such as Last Tango in Paris, Superman, and Apocalypse Now.', 4, 32),
	(8, 'The Godfather 2', 'The Godfather Part II is a 1974 American epic crime film produced and directed by Francis Ford Coppola from the screenplay co-written with Mario Puzo, starring Al Pacino, Robert Duvall, Diane Keaton, Robert De Niro, Talia Shire, Morgana King, John Cazale, Mariana Hill, and Lee Strasberg. It is the second installment in The Godfather trilogy. Partially based on Puzo''s 1969 novel The Godfather, the film serves as both a sequel and a prequel to The Godfather, presenting parallel dramas: one picks up the 1958 story of Michael Corleone (Pacino), the new Don of the Corleone family, protecting the family business in the aftermath of an attempt on his life; the prequel covers the journey of his father, Vito Corleone (De Niro), from his Sicilian childhood to the founding of his family enterprise in New York City.

Following the success of the first film, Paramount Pictures began developing a follow-up to the film, with much of the same cast and crew returning. Coppola, who was given more creative control over the film, had wanted to make both a sequel and a prequel to the film that would tell the story of the rise of Vito and the fall of Michael. Principal photography began in October 1973 and wrapped up in June 1974. The Godfather Part II premiered in New York City on December 12, 1974, and was released in the United States on December 20, 1974, receiving divided reviews from critics but its reputation, however, improved rapidly and it soon became the subject of critical re-appraisal. It grossed between $48–88 million worldwide on a $13 million budget. The film was nominated for eleven Academy Awards at the 47th Academy Awards and became the first sequel to win for Best Picture. Its six Oscar wins also included Best Director for Coppola, Best Supporting Actor for De Niro and Best Adapted Screenplay for Coppola and Puzo. Pacino won the BAFTA Award for Best Actor and was nominated for the Academy Award for Best Actor.', 4, 32),
	(9, 'Schindler''s List', 'Schindler''s List is a 1993 American epic historical drama film directed and produced by Steven Spielberg and written by Steven Zaillian. It is based on the 1982 non-fiction novel Schindler''s Ark by Australian novelist Thomas Keneally. The film follows Oskar Schindler, a German industrialist who saved more than a thousand mostly Polish-Jewish refugees from the Holocaust by employing them in his factories during World War II. It stars Liam Neeson as Schindler, Ralph Fiennes as SS officer Amon Göth and Ben Kingsley as Schindler''s Jewish accountant Itzhak Stern.

Ideas for a film about the Schindlerjuden (Schindler Jews) were proposed as early as 1963. Poldek Pfefferberg, one of the Schindlerjuden, made it his life''s mission to tell Schindler''s story. Spielberg became interested when executive Sidney Sheinberg sent him a book review of Schindler''s Ark. Universal Pictures bought the rights to the novel, but Spielberg, unsure if he was ready to make a film about the Holocaust, tried to pass the project to several directors before deciding to direct it.

Principal photography took place in Kraków, Poland, over 72 days in 1993. Spielberg shot in black and white and approached the film as a documentary. Cinematographer Janusz Kamiński wanted to create a sense of timelessness. John Williams composed the score, and violinist Itzhak Perlman performed the main theme.', 4, 33),
	(10, 'The Dark Knight', 'DC Comics relaunched Batman: The Dark Knight with issue #1 in September 2011, as part of The New 52. While David Finch was originally supposed to be the writer on the series permanently, Paul Jenkins was later announced to be co-writing issues. Joe Harris and Judd Winick had guest appearances before Gregg Hurwitz would take over the series.[3]

Knight Terrors: As Bruce is unable to keep up with the various legal conspiracies involving Batman Incorporated, he decides to investigate a breakout in Arkham. There he finds criminals being fed a modified fear toxin that is mixed in with venom which makes the criminals extremely strong and immune to fear. He finds it being given to criminals by a new foe named the White Rabbit. When Batman approaches her she quickly defeats him and injects him with the fear toxin which she then gives to the Flash. Bruce then finds Bane to be behind the new fear toxin and combats him, Bruce manages to burn the fear toxin out of his and the Flash''s body''s by getting pushed to the limit. Bruce manages to defeat Bane, but is left confused by the White Rabbit', 4, 34);


--
-- Data for Name: places; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.places VALUES
	(16, 'Galata Kulesi', 34, 90, 'Galata Kulesi ya da müze olarak kullanılmaya başlaması sonrasındaki adıyla Galata Kulesi Müzesi, Türkiye''nin İstanbul şehrinin Beyoğlu ilçesinde bulunan bir kuledir. Adını, bulunduğu Galata semtinden alır. Galata Surları dahilinde bir gözetleme kulesi olarak inşa edilen kule günümüzde, bir sergi alanı ve müze olarak kullanılır. Hem Beyoğlu''nun hem de İstanbul''un sembol yapılarından biridir.

Bizans İmparatorluğu ile ittifak hâlinde olan Cenevizliler 1267''de, Haliç''in kuzeyinde bulunan Galata''da "Pera" adlı bir koloni kurmuş, bu koloninin hâkimiyet alanını da zaman içinde Bizans tarafından verilen izinlerle genişletmişti. Tepesindeki haçtan ötürü o dönem "Kutsal Haç Kulesi" (Turris Sancte Crucis) olarak adlandırılan kule de, bu izinlere aykırı bir şekilde kuzeydoğu yönündeki tepeye doğru hâkimiyet alanı artırılarak 1335-1349 yılları arasında bölgede yapılan tahkimatların bir parçası olarak inşa edildi. İki devlet arasında o yıl patlak veren savaş, ertesi yıl imzalanan antlaşmayla sona ererken kulenin bulunduğu tepe Ceneviz kontrolüne bırakıldı. Konstantinopolis''in 29 Mayıs 1453''te Osmanlı İmparatorluğu tarafından alınması sonrasında Pera''daki Cenevizliler, herhangi bir çatışma yaşanmadan koloniyi Osmanlı''ya devretti. Kulenin de dâhil olduğu Galata''daki tahkimatlarda birtakım tahribatlar gerçekleştirilse de, Osmanlı Padişahı II. Mehmed''in fermanıyla kuledeki tahribatlar durduruldu ve tahrip edilen kısımlar yeniden inşa edildi. 1509''daki depremde hasar gören kule, 1510 itibarıyla onarıldı. 16. ve 17. yüzyıllarda, savaş esirlerini tutma yeri ve levazım ambarı, 18. yüzyıl itibarıyla Mehterhâne Ocağı ile yangın gözleyiciler tarafından bir yangın kulesi olarak kullanıldı.

1794''teki yangın sonrasında yapılan onarım çalışmalarında kulenin tasarımı değiştirilirken üst kısım bir kahvehaneye dönüştürüldü. 1831''deki yangın sonrasında tasarımı bir kez daha değiştirildi. 1875''teki bir fırtınada çatısının devrilmesinin ardından en üst katın üzerine kâgir iki ahşap kat çıkılarak bu kısım, şehirde çıkan yangınları gözleme ve haber verme amacıyla kullanılmaya başlandı. 1965-1967 yılları arasındaki restorasyon çalışmasıyla kule, katları farklı amaçlara hizmet eden turistik bir yapı olarak düzenlenirken kulenin çatısı da 1832-1876 yılları arasındaki tasarıma benzer şekilde yenilendi. Bu dönemde, Ünal Kardeşler ile sonrasındaki dönemde vârislerine ait şirket tarafından İstanbul Belediyesinden kiralanarak işletilmeye başlandı. 1999-2000 yıllarında dış cephesinde bir restorasyon yapıldı. 2013''te, İstanbul Büyükşehir Belediyesine bağlı BELTUR işletmeyi devraldı. Bu dönemde kulenin en üst iki katında birer kafe ile restoran yer almaktaydı. Aynı yıl, UNESCO tarafından Türkiye''deki Dünya Mirası Geçici Listesi''ne dâhil edildi. 2019''da mülkiyeti ve işletmesi Vakıflar Genel Müdürlüğüne geçti. 2020''de yapılan çalışmalar sonrasında kule, müze ve sergi mekânı olarak düzenlendi ve kullanılmaya başlandı.

Çatısının ucuna kadar olan yüksekliği 62,59 m olan Romanesk tarzdaki kâgir kulenin silindirik gövdesi taştandır. Birer bodrum, zemin ve asma kat dâhil olmak üzere 11 katı bulunur. Zemin katla altıncı kat arasında asansör yer alırken, zemin kattan dördüncü kata kadar taş merdivenler, altıncı kattan sekizinci kata kadar ise çelik konstrüksiyon merdivenler yer alır. ', 32),
	(17, 'Selimiye Camii', 22, 90, 'Selimiye Cami, Edirne''de bulunan, Osmanlı padişahı II. Selim''in Mimar Sinan''a yaptırdığı camidir. Sinan''ın 90 (bazı kitaplarda 80 olarak geçer) yaşında yaptığı ve "ustalık eserim" dediği[1] Selimiye Camii gerek Mimar Sinan''ın gerek Osmanlı mimarisinin en önemli yapıtlarından biridir.[2]

Caminin kapısındaki kitabeye göre yapımına 1568 (Hicri: 976) yılında başlanmıştır. Caminin 27 Kasım 1574 Cuma günü açılması planlanmışsa da ancak II. Selim''in ölümünün ardından 14 Mart 1575''te ibadete açılmıştır.[3][4]

Mülkiyeti Sultan Selim Vakfı’ndadır[5]. Bugün şehrin merkezinde bulunan caminin yapıldığı alanda inşasına Süleyman Çelebi döneminde başlanan, sonradan Yıldırım Bayezid''in geliştirdiği Edirne''nin ilk sarayı (Saray-ı elik) ve Baltacı Muhafızları haremi bulunmaktaydı. Bu alandan “Sarıbayır” veya “Kavak Meydanı” diye bahsedilir.[5]

2000''de UNESCO tarafından Dünya Mirası Geçici Listesi''ne dahil edilen[6] Selimiye Camii ve Külliyesi, 2011''de ise Dünya Mirası olarak tescil edildi.[', 33),
	(18, 'Peri Bacaları', 50, 90, 'Peri bacası, ince uzun, kurak havzalardan ve kırgıbayır yüzeylerinden çıkan, vadi yamaçlarından inen sel sularının yeri aşındırmasıyla oluşan bir kaya oluşumudur. Peri bacalarının gövdeleri genellikle yumuşak minerallerden ve tepesi sert, daha zor aşınan kayadan oluşur. Gövdeleri genellikle konik şekle sahiptir. Şekilleri erozyon biçimlerine göre değişir. Farklı mineral katmanları(sedimanter ve volkanik kayaç) gövdelerinde farklı renklere sebep olabilir. Çapları 1 ile 15 metre arasında değişir, bu sınırlamanın dışına çıkan oluşumlar peri bacası olarak sınıflandırılamazlar. Peri Bacaları esas olarak çölde kuru ve sıcak bölgelerde bulunur. Yaygın kullanımda kukuletalar(üzerindeki şapka tipi kayaç) veya kuleler arasındaki fark, kukuletaların totem direği şeklindeki bir gövdeye sahip olarak tanımlanırken değişken bir kalınlığa da sahiptir.

Hoodoolar (Peri bacası) çoğunlukla çölde kuru ve sıcak bölgelerde bulunur. Yaygın kullanımda, kapüşonlular ve tepeler (veya kuleler) arasındaki fark, kapüşonların genellikle "totem direği şeklinde bir gövdeye" sahip olarak tanımlanan değişken bir kalınlığa sahip olmasıdır. Ancak sivri uç, zeminden yukarı doğru sivrilen daha pürüzsüz bir profile veya tek tip kalınlığa sahiptir.

Hoodoos, ortalama bir insanın boyundan 10 katlı bir binayı aşan yüksekliklere kadar değişir. Hoodoo şekilleri, değişen sert ve daha yumuşak kaya katmanlarının erozyon modellerinden etkilenir. Farklı kaya türleri içinde biriken mineraller, kaputoların yükseklikleri boyunca farklı renklere sahip olmasına neden olur.', 34),
	(19, 'Ayasofya', 34, 90, 'İstanbul’un gözbebeği Tarihi Yarımada’yı gezmeye başlamak için en doğru yer Ayasofya Cami.

Dünyanın en tanınmış ibadethanelerinden biri olarak aynı yerde 3 defa inşa edilen Ayasofya, son halini 537 yılında aldı.

Ayasofya’nın ibadete açıldığı gün İmparator Justinianos’un, “Tanrım bana böyle bir ibadet yeri yapabilme fırsatı sağladığın için şükürler olsun” dediği ve Kudüs’teki Hz. Süleyman Mabedi’ni kastederek “Ey Süleyman seni geçtim” diye bağırdığı rivayet ediliyor.

İstanbul’un fethinden sonra cami olarak ibadete açılan Ayasofya’nın içine mihraplar, minber, müezzin mahfilleri, vaaz kürsüsü ve maksureler eklendi. Bir dönem müze olarak ziyarete açılan Ayasofya, şu an cami olarak yeniden ibadete açık durumda.', 32),
	(20, 'Topkapı Sarayı', 34, 90, 'Osmanlı İmparatorluğu, dünyanın en geniş sınırlara ulaşmış ve yüzyıllarca hakimiyetini sürdürmüş imparatorluklarından biri. Bu köklü tarihin ve ihtişamlı yapının 400 yıl boyunca yönetildiği, sultanların ve ailelerinin yaşadığı Topkapı Sarayı ise bütün görkemiyle Tarihi Yarımada’da görülmeyi bekliyor.

Osmanlı’nın en şatafatlı düğünlerine, tahta çıkma törenlerine ya da entrikalarına ve hüzünlü hikayelerine şahit olan bu sarayda, kendinizi tarihin kollarına bırakarak eşsiz bir tarihe tanık olabilirsiniz.

Topkapı Sarayı Müzesi ve Harem Gezisi’nde görülecek yerler arasında sarayın Harem bölümü, Hırka-ı Saadet Dairesi ve Has Oda bölümü, Babü’s Saade bölümü ve Köşkler Bahçesi bölümü bulunuyor.', 35);


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.questions VALUES
	(23, 'Arkadaşlar Bursa Uludağ Sosyoloji bölümü nasıldır. Tercih etmeli miyim?', 33, 6),
	(24, 'Arkadaşlar Bilgisayar Mühendisliği için hangi üniversite daha iyi olur?', 32, 6),
	(25, 'İstanbulda üniversite okumalı mıyım?', 34, 6);


--
-- Data for Name: rank; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rank VALUES
	(1, 'SOLDIER'),
	(2, 'SERGEANT'),
	(3, 'LIEUTENANT'),
	(4, 'COLONEL'),
	(5, 'GENERAL');


--
-- Data for Name: replies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.replies VALUES
	(22, 'Üniversite ve bölümden ziyade ülkemizdeki durumuna bakmalısın bence', 23, 34),
	(23, 'Gayet güzel.', 23, 32),
	(24, 'Ben olsam Sakarya yazardım.', 24, 34),
	(25, 'Sıralamanı bilmeden bir şey diyemeyiz ki', 24, 32),
	(26, 'Bence istanbul harika. Kesinlikle okuyabilen orda okusun', 25, 35),
	(27, 'Eziyet gibi bir şehir. Uzak dur.', 25, 33),
	(28, 'İstanbul aşktır. Orda okumak başkadır.', 25, 32);


--
-- Data for Name: seriereplies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.seriereplies VALUES
	(8, 5, 32, 'Çok eski bir film. Ayrıca Jerry o kadarda komik değilsin dostum.'),
	(9, 6, 34, 'Hiç bıkmadan tekrar tekrar izlerim. Çok samimi bir dizi. Favorim.'),
	(10, 6, 35, 'Sonu tam bir hayal kırıklığı olsada hımym baş tacıdır.'),
	(11, 6, 32, 'Ben bu diziye ba-yıl-dım'),
	(12, 7, 33, 'Avartıldığı kadar iyi değil. Kadro güzel olabilir ama işleniş hımym in yanından geçemez.'),
	(13, 7, 32, 'Bunu bir de hımym ile karşılaştırıyorlar.'),
	(14, 8, 34, 'parça parça yayınlandığı için bağlıyor ama tek oturuşta izlense sıkar.'),
	(15, 8, 35, 'Zaman geçirmelik güzel dizi'),
	(16, 8, 33, 'İzlemek çok keyifliydi.'),
	(17, 8, 32, 'Parça parça yayınlayıp adamı hasta ediyorlar.'),
	(18, 9, 32, 'Ben bu filme aşık oldum.'),
	(19, 9, 33, 'Scofield nesin sen dostum, einstein ın yeğeni falan mı'),
	(20, 9, 35, 'Mesleğiniz ne ?
Hapishaneden adam kaçırmak. :)'),
	(21, 9, 34, 'Gel beni de bu ülkeden kaçır :)'),
	(22, 9, 32, 'Vay beee. Adam neymiş');


--
-- Data for Name: series; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.series VALUES
	(5, 'Seinfeld', 'an American sitcom television series created by Larry David and Jerry Seinfeld. It aired on NBC from July 5, 1989, to May 14, 1998, over nine seasons and 180 episodes. It stars Seinfeld as a fictionalized version of himself and focuses on his personal life with three of his friends: George Costanza (Jason Alexander), former girlfriend Elaine Benes (Julia Louis-Dreyfus), and his neighbor from across the hall, Cosmo Kramer (Michael Richards). It is set mostly in an apartment building in Manhattan''s Upper West Side in New York City. It has been described as "a show about nothing", often focusing on the minutiae of daily life.[1]

As a rising comedian in the late 1980s, Jerry Seinfeld was presented with an opportunity to create a show with NBC. He asked David, a fellow comedian and friend, to help create a premise for a sitcom.[2] The series was produced by West-Shapiro Productions and Castle Rock Entertainment, and distributed by Columbia Pictures Television.[nb 2] It was largely written by David and Seinfeld, with script writers who included Larry Charles, Peter Mehlman, Gregg Kavet, Carol Leifer, David Mandel, Jeff Schaffer, Steve Koren, Jennifer Crittenden, Tom Gammill, Max Pross, Dan O''Keefe, Charlie Rubin, Marjorie Gross, Alec Berg, Elaine Pope, and Spike Feresten. A favorite among critics, the series led the Nielsen ratings in seasons six and nine, and finished among the top two (with NBC''s ER) every year from 1994 to 1998. Only two other shows, I Love Lucy and The Andy Griffith Show, have finished their runs at the top of the ratings.[3]', 3, 35),
	(6, 'How I Met Your Mother', 'How I Met Your Mother (often abbreviated as HIMYM) is an American sitcom, created by Craig Thomas and Carter Bays for CBS. The series, which ran from 2005 to 2014, follows the main character, Ted Mosby, and his group of friends in New York City''s Manhattan. As a framing device, Ted, in the year 2030, recounts to his son, Luke, and daughter, Penny, the events from September 2005 to May 2013 that led him to meet their mother. How I Met Your Mother is a joint production by Bays & Thomas Productions and 20th Television and syndicated by 20th Television (now Disney-ABC Domestic Television).

The series was loosely inspired by Thomas and Bays'' friendship when they both lived in Chicago[1] The vast majority of episodes were directed by Pamela Fryman, who directed 196 episodes out of 208. The other directors were Rob Greenberg (7 episodes), Michael Shea (4 episodes), and Neil Patrick Harris (1 episode).

Known for its unique structure, humor, and incorporation of dramatic elements, How I Met Your Mother was popular throughout its run. The show initially received positive reviews upon release, but reception became more mixed as the seasons went on.[2][3][4][5] The show was nominated for 30 Emmy Awards and won ten. In 2010, Alyson Hannigan won the People''s Choice Award for Favorite TV Comedy Actress. In 2012, seven years after its premiere, the series won the People''s Choice Award for Favorite Network TV Comedy, and Neil Patrick Harris won the award for Favorite TV Comedy Actor twice.', 3, 34),
	(7, 'Friends', 'Friends is an American television sitcom created by David Crane and Marta Kauffman, which aired on NBC from September 22, 1994, to May 6, 2004, lasting ten seasons.[1] With an ensemble cast starring Jennifer Aniston, Courteney Cox, Lisa Kudrow, Matt LeBlanc, Matthew Perry and David Schwimmer, the show revolves around six friends in their 20s and 30s who live in Manhattan, New York City. The series was produced by Bright/Kauffman/Crane Productions, in association with Warner Bros. Television. The original executive producers were Kevin S. Bright, Kauffman, and Crane.

Kauffman and Crane began developing Friends under the working title Insomnia Cafe between November and December 1993. They presented the idea to Bright, and together they pitched a seven-page treatment of the show to NBC. After several script rewrites and changes, including title changes to Six of One[2] and Friends Like Us, the series was finally named Friends.[3]

Filming took place at Warner Bros. Studios in Burbank, California. All ten seasons of Friends ranked within the top ten of the final television season ratings; it ultimately reached the number-one spot in its eighth season. The series finale aired on May 6, 2004, and was watched by around 52.5 million American viewers, making it the fifth-most-watched series finale in television history[4][5][6] and the most-watched television episode of the 2000s.[7][8]

Friends received acclaim throughout its run, becoming one of the most popular television shows of all time.[9] The series was nominated for 62 Primetime Emmy Awards, winning the Outstanding Comedy Series award in 2002[10] for its eighth season. The show ranked no. 21 on TV Guide''s 50 Greatest TV Shows of All Time,[11] and no. 7 on Empire magazine''s The 50 Greatest TV Shows of All Time.[12][13] In 1997, the episode "The One with the Prom Video" was ranked no. 100 on TV Guide''s 100 Greatest Episodes of All-Time.[14] In 2013, Friends ranked no. 24 on the Writers Guild of America''s 101 Best Written TV Series of All Time,[15] and no. 28 on TV Guide''s 60 Best TV Series of All Time.[16] The sitcom''s cast members returned for a reunion special aired on HBO Max on May 27, 2021.', 3, 32),
	(8, 'La Casa De Papel', 'The series was initially intended as a limited series to be told in two parts. It had its original run of 15 episodes on Spanish network Antena 3 from 2 May 2017 through 23 November 2017. Netflix acquired global streaming rights in late 2017. It re-cut the series into 22 shorter episodes and released them worldwide, beginning with the first part on 20 December 2017, followed by the second part on 6 April 2018. In April 2018, Netflix renewed the series with a significantly increased budget for 16 new episodes total. Part 3, with eight episodes, was released on 19 July 2019. Part 4, also with eight episodes, was released on 3 April 2020. A documentary involving the producers and the cast premiered on Netflix the same day, titled Money Heist: The Phenomenon (Spanish: La casa de papel: El Fenómeno). In July 2020, Netflix renewed the show for a fifth and final part, which was released in two five-episode volumes on 3 September and 3 December 2021, respectively. The series was filmed in Madrid, Spain. Significant portions were also filmed in Panama, Thailand, Italy (Florence), Denmark and in Portugal.

The series received several awards including the International Emmy Award for Best Drama Series at the 46th International Emmy Awards, as well as critical acclaim for its sophisticated plot, interpersonal dramas, direction, and for trying to innovate Spanish television. The Italian anti-fascist song "Bella ciao", which plays multiple times throughout the series, became a summer hit across Europe in 2018. By 2018, the series was the most-watched non-English-language series and one of the most-watched series overall on Netflix,[4] having particular resonance with viewers from Mediterranean Europe and the Latin American regions.', 2, 33),
	(9, 'Prison Break', 'The series was originally turned down by Fox in 2003, which was concerned about the long-term prospects of such a series. Following the popularity of serialized prime time television series Lost and 24, Fox decided to back production in 2004. The first season received mostly positive reviews from critics with universal acclaim from audiences.[2] Furthermore, it performed exceptionally in the ratings and was originally planned for a 13-episode run, but was extended to include an extra nine episodes due to its popularity. The subsequent seasons continued to receive strong ratings, however, with some critics claiming the show had overstayed its welcome.[3] Prison Break was nominated for several industry awards, including the 2005 Golden Globe Award for Best Television Series Drama and the 2006 People''s Choice Award for Favorite New TV Drama, which it won. In the United States, all five seasons have been released on DVD and released on Blu-ray internationally.

The success of the series has inspired short videos for mobile phones, several official tie-ins in print and on the Internet, and a video game. A spin-off series, Prison Break: Proof of Innocence, was produced exclusively for mobile phones. The series has spawned an official magazine and a tie-in novel. The fourth season of Prison Break returned from its mid-season break in a new timeslot on April 17, 2009, for the series'' last six episodes.[4] Two additional episodes, titled "The Old Ball and Chain" and "Free" were produced, and were later transformed into a standalone feature, titled The Final Break. The events of this feature take place before the last scene of the series finale, and are intended to conclude unfinished plotlines. The feature was released on DVD and Blu-ray July 21, 2009.[5]', 2, 32);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES
	(34, 'elf54', 'dmrc54', 'Elif', 'Demirci', 1, 131),
	(35, 'sbl54', 'grn54', 'Sibel', 'Geren', NULL, NULL),
	(31, 'admin', 'admin', 'Admin', 'Admin', NULL, NULL),
	(32, 'ctn.mhmmd', 'cetin54', 'Muhammed', 'Çetin', 1, 234),
	(33, 'mrym54', 'ztly54', 'Meryem', 'Özatalay', 1, 106);


--
-- Name: categories_categoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_categoryid_seq', 6, true);


--
-- Name: filmcategories_catid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.filmcategories_catid_seq', 11, true);


--
-- Name: horoscopefeatures_featuresid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.horoscopefeatures_featuresid_seq', 12, true);


--
-- Name: horoscopereplies_hreplieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.horoscopereplies_hreplieid_seq', 14, true);


--
-- Name: horoscopes_horoscopeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.horoscopes_horoscopeid_seq', 12, true);


--
-- Name: messages_messageid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_messageid_seq', 52, true);


--
-- Name: moviereplies_mreplieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.moviereplies_mreplieid_seq', 57, true);


--
-- Name: movies_movieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_movieid_seq', 10, true);


--
-- Name: places_placeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.places_placeid_seq', 20, true);


--
-- Name: questions_questionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_questionid_seq', 25, true);


--
-- Name: rank_rankid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rank_rankid_seq', 5, true);


--
-- Name: replies_replyid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.replies_replyid_seq', 28, true);


--
-- Name: seriereplies_sreplieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seriereplies_sreplieid_seq', 22, true);


--
-- Name: series_serieid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.series_serieid_seq', 9, true);


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_userid_seq', 35, true);


--
-- Name: categories categories_categoryname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_categoryname_key UNIQUE (categoryname);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (categoryid);


--
-- Name: cities cities_cityname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_cityname_key UNIQUE (cityname);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (citycode);


--
-- Name: countries countries_countryname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_countryname_key UNIQUE (countryname);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (countrycode);


--
-- Name: filmcategories filmcategories_catname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filmcategories
    ADD CONSTRAINT filmcategories_catname_key UNIQUE (catname);


--
-- Name: filmcategories filmcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filmcategories
    ADD CONSTRAINT filmcategories_pkey PRIMARY KEY (catid);


--
-- Name: horoscopefeatures horoscopefeatures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horoscopefeatures
    ADD CONSTRAINT horoscopefeatures_pkey PRIMARY KEY (featuresid);


--
-- Name: horoscopereplies horoscopereplies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horoscopereplies
    ADD CONSTRAINT horoscopereplies_pkey PRIMARY KEY (hreplieid);


--
-- Name: horoscopes horoscopes_horoscopename_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horoscopes
    ADD CONSTRAINT horoscopes_horoscopename_key UNIQUE (horoscopename);


--
-- Name: horoscopes horoscopes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horoscopes
    ADD CONSTRAINT horoscopes_pkey PRIMARY KEY (horoscopeid);


--
-- Name: messages messages_mcontent_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_mcontent_key UNIQUE (mcontent);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (messageid);


--
-- Name: moviereplies moviereplies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moviereplies
    ADD CONSTRAINT moviereplies_pkey PRIMARY KEY (mreplieid);


--
-- Name: movies movies_moviename_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_moviename_key UNIQUE (moviename);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movieid);


--
-- Name: places places_content_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_content_key UNIQUE (content);


--
-- Name: places places_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_pkey PRIMARY KEY (placeid);


--
-- Name: places places_placename_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_placename_key UNIQUE (placename);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (questionid);


--
-- Name: questions questions_qcontent_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_qcontent_key UNIQUE (qcontent);


--
-- Name: rank rank_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rank
    ADD CONSTRAINT rank_pkey PRIMARY KEY (rankid);


--
-- Name: rank rank_rankname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rank
    ADD CONSTRAINT rank_rankname_key UNIQUE (rankname);


--
-- Name: replies replies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.replies
    ADD CONSTRAINT replies_pkey PRIMARY KEY (replyid);


--
-- Name: seriereplies seriereplies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seriereplies
    ADD CONSTRAINT seriereplies_pkey PRIMARY KEY (sreplieid);


--
-- Name: series series_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT series_pkey PRIMARY KEY (serieid);


--
-- Name: series series_seriename_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT series_seriename_key UNIQUE (seriename);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: fki_F; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_F" ON public.questions USING btree (userid);


--
-- Name: fki_fk_categoryid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_categoryid ON public.messages USING btree (categoryid);


--
-- Name: fki_fk_catid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_catid ON public.series USING btree (catid);


--
-- Name: fki_fk_country; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_country ON public.cities USING btree (countrycode);


--
-- Name: fki_fk_movie; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_movie ON public.movies USING btree (catid);


--
-- Name: fki_fk_movieid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_movieid ON public.moviereplies USING btree (movieid);


--
-- Name: fki_fk_questionid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_questionid ON public.replies USING btree (questionid);


--
-- Name: fki_fk_rankid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_rankid ON public.users USING btree (rankid);


--
-- Name: fki_fk_serieid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_serieid ON public.seriereplies USING btree (serieid);


--
-- Name: fki_fk_seriesid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_seriesid ON public.seriereplies USING btree (serieid);


--
-- Name: fki_fk_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_user ON public.movies USING btree (userid);


--
-- Name: fki_fk_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_userid ON public.messages USING btree (userid);


--
-- Name: fki_fkcityid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fkcityid ON public.places USING btree (citycode);


--
-- Name: horoscopereplies ranktrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrig AFTER INSERT ON public.horoscopereplies FOR EACH STATEMENT EXECUTE FUNCTION public.addpointstousers();


--
-- Name: messages ranktrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrig AFTER INSERT ON public.messages FOR EACH STATEMENT EXECUTE FUNCTION public.addpointstousers();


--
-- Name: moviereplies ranktrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrig AFTER INSERT ON public.moviereplies FOR EACH STATEMENT EXECUTE FUNCTION public.addpointstousers();


--
-- Name: movies ranktrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrig AFTER INSERT ON public.movies FOR EACH STATEMENT EXECUTE FUNCTION public.addpointstousers();


--
-- Name: places ranktrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrig AFTER INSERT ON public.places FOR EACH STATEMENT EXECUTE FUNCTION public.addpointstousers();


--
-- Name: questions ranktrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrig AFTER INSERT ON public.questions FOR EACH STATEMENT EXECUTE FUNCTION public.addpointstousers();


--
-- Name: replies ranktrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrig AFTER INSERT ON public.replies FOR EACH STATEMENT EXECUTE FUNCTION public.addpointstousers();


--
-- Name: seriereplies ranktrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrig AFTER INSERT ON public.seriereplies FOR EACH STATEMENT EXECUTE FUNCTION public.addpointstousers();


--
-- Name: series ranktrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrig AFTER INSERT ON public.series FOR EACH STATEMENT EXECUTE FUNCTION public.addpointstousers();


--
-- Name: horoscopereplies ranktrigg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrigg AFTER INSERT ON public.horoscopereplies FOR EACH STATEMENT EXECUTE FUNCTION public.sysrank();


--
-- Name: messages ranktrigg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrigg AFTER INSERT ON public.messages FOR EACH STATEMENT EXECUTE FUNCTION public.sysrank();


--
-- Name: moviereplies ranktrigg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrigg AFTER INSERT ON public.moviereplies FOR EACH STATEMENT EXECUTE FUNCTION public.sysrank();


--
-- Name: movies ranktrigg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrigg AFTER INSERT ON public.movies FOR EACH STATEMENT EXECUTE FUNCTION public.sysrank();


--
-- Name: places ranktrigg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrigg AFTER INSERT ON public.places FOR EACH STATEMENT EXECUTE FUNCTION public.sysrank();


--
-- Name: questions ranktrigg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrigg AFTER INSERT ON public.questions FOR EACH STATEMENT EXECUTE FUNCTION public.sysrank();


--
-- Name: replies ranktrigg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrigg AFTER INSERT ON public.replies FOR EACH STATEMENT EXECUTE FUNCTION public.sysrank();


--
-- Name: seriereplies ranktrigg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrigg AFTER INSERT ON public.seriereplies FOR EACH STATEMENT EXECUTE FUNCTION public.sysrank();


--
-- Name: series ranktrigg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ranktrigg AFTER INSERT ON public.series FOR EACH STATEMENT EXECUTE FUNCTION public.sysrank();


--
-- Name: horoscopereplies renewtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER renewtrig AFTER INSERT ON public.horoscopereplies FOR EACH STATEMENT EXECUTE FUNCTION public.renew();


--
-- Name: messages renewtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER renewtrig AFTER INSERT ON public.messages FOR EACH STATEMENT EXECUTE FUNCTION public.renew();


--
-- Name: moviereplies renewtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER renewtrig AFTER INSERT ON public.moviereplies FOR EACH STATEMENT EXECUTE FUNCTION public.renew();


--
-- Name: movies renewtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER renewtrig AFTER INSERT ON public.movies FOR EACH STATEMENT EXECUTE FUNCTION public.renew();


--
-- Name: places renewtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER renewtrig AFTER INSERT ON public.places FOR EACH STATEMENT EXECUTE FUNCTION public.renew();


--
-- Name: questions renewtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER renewtrig AFTER INSERT ON public.questions FOR EACH STATEMENT EXECUTE FUNCTION public.renew();


--
-- Name: replies renewtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER renewtrig AFTER INSERT ON public.replies FOR EACH STATEMENT EXECUTE FUNCTION public.renew();


--
-- Name: seriereplies renewtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER renewtrig AFTER INSERT ON public.seriereplies FOR EACH STATEMENT EXECUTE FUNCTION public.renew();


--
-- Name: series renewtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER renewtrig AFTER INSERT ON public.series FOR EACH STATEMENT EXECUTE FUNCTION public.renew();


--
-- Name: messages fk_categoryid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_categoryid FOREIGN KEY (categoryid) REFERENCES public.categories(categoryid) NOT VALID;


--
-- Name: questions fk_categoryid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fk_categoryid FOREIGN KEY (categoryid) REFERENCES public.categories(categoryid) NOT VALID;


--
-- Name: series fk_catid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT fk_catid FOREIGN KEY (catid) REFERENCES public.filmcategories(catid) NOT VALID;


--
-- Name: horoscopefeatures fk_catid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horoscopefeatures
    ADD CONSTRAINT fk_catid FOREIGN KEY (horoscopeid) REFERENCES public.horoscopes(horoscopeid) NOT VALID;


--
-- Name: horoscopereplies fk_catid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horoscopereplies
    ADD CONSTRAINT fk_catid FOREIGN KEY (horoscopeid) REFERENCES public.horoscopes(horoscopeid) NOT VALID;


--
-- Name: cities fk_country; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT fk_country FOREIGN KEY (countrycode) REFERENCES public.countries(countrycode) NOT VALID;


--
-- Name: places fk_country; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT fk_country FOREIGN KEY (countrycode) REFERENCES public.countries(countrycode) NOT VALID;


--
-- Name: movies fk_movie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT fk_movie FOREIGN KEY (catid) REFERENCES public.filmcategories(catid) NOT VALID;


--
-- Name: moviereplies fk_movieid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moviereplies
    ADD CONSTRAINT fk_movieid FOREIGN KEY (movieid) REFERENCES public.movies(movieid) NOT VALID;


--
-- Name: replies fk_questionid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.replies
    ADD CONSTRAINT fk_questionid FOREIGN KEY (questionid) REFERENCES public.questions(questionid) NOT VALID;


--
-- Name: users fk_rankid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rankid FOREIGN KEY (rankid) REFERENCES public.rank(rankid) NOT VALID;


--
-- Name: seriereplies fk_seriesid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seriereplies
    ADD CONSTRAINT fk_seriesid FOREIGN KEY (serieid) REFERENCES public.series(serieid) NOT VALID;


--
-- Name: messages fk_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_userid FOREIGN KEY (userid) REFERENCES public.users(userid) NOT VALID;


--
-- Name: replies fk_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.replies
    ADD CONSTRAINT fk_userid FOREIGN KEY (userid) REFERENCES public.users(userid) NOT VALID;


--
-- Name: questions fk_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fk_userid FOREIGN KEY (userid) REFERENCES public.users(userid) NOT VALID;


--
-- Name: movies fk_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT fk_userid FOREIGN KEY (userid) REFERENCES public.users(userid) NOT VALID;


--
-- Name: series fk_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT fk_userid FOREIGN KEY (userid) REFERENCES public.users(userid) NOT VALID;


--
-- Name: horoscopereplies fk_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horoscopereplies
    ADD CONSTRAINT fk_userid FOREIGN KEY (userid) REFERENCES public.users(userid) NOT VALID;


--
-- Name: places fk_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT fk_userid FOREIGN KEY (userid) REFERENCES public.users(userid) NOT VALID;


--
-- Name: moviereplies fk_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moviereplies
    ADD CONSTRAINT fk_userid FOREIGN KEY (userid) REFERENCES public.users(userid) NOT VALID;


--
-- Name: seriereplies fk_userid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seriereplies
    ADD CONSTRAINT fk_userid FOREIGN KEY (userid) REFERENCES public.users(userid) NOT VALID;


--
-- Name: places fkcityid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT fkcityid FOREIGN KEY (citycode) REFERENCES public.cities(citycode) NOT VALID;


--
-- PostgreSQL database dump complete
--

