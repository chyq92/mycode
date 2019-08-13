USE sql_train1;

#1
select *
from orders 
where salesman_id =
(select salesman_id
 from salesman
 where name='Paul Adam');

select a.*
from orders a inner join salesman b
on a.salesman_id = b.salesman_id and b.name='Paul Adam';

#2
select *
from orders 
where salesman_id in
(select salesman_id
 from salesman
 where city = 'London');

select a.*
from orders a inner join salesman b
on a.salesman_id = b.salesman_id and b.city='London';

#3
select *
from orders
where salesman_id =
(select salesman_id
 from customer
 where customer_id = 3007);

select a.*
from orders a inner join customer b
on a.salesman_id = b.salesman_id and b.customer_id = 3007;
 
#4
select *
from orders
where purch_amt >
(select avg(purch_amt)
 from orders
 where ord_date = '2012-10-10');
 
#5
select *
from orders 
where salesman_id in
(select salesman_id
 from salesman
 where city = 'New York');

select a.*
from orders a inner join salesman b
on a.salesman_id = b.salesman_id and b.city='New York';

#6
select *
from salesman
where salesman_id in
(select salesman_id
 from customer
 where city = 'Paris');
 
select a.*
from orders a inner join customer b
on a.salesman_id = b.salesman_id and b.city='Paris';

#7
select *
from customer
where customer_id =
(select salesman_id-2001
 from salesman
 where name = 'Mc Lyon');
 
#8
select grade, count(customer_id)
from customer
group by grade
having grade >  
(select avg(grade)
 from customer
 where city = 'New York');
  
#9
select *
from customer
where customer_id in
(select customer_id
 from orders
 where ord_date = '2012-10-05');
 
select a.*
from customer a inner join orders b
on a.customer_id = b.customer_id and b.ord_date='2012-10-05';

select a.*, b.ord_no, b.ord_date, b.purch_amt
from customer a inner join orders b
on a.customer_id = b.customer_id and b.ord_date='2012-10-05';
 
#10
select *
from customer
where customer_id in
(select customer_id
 from orders
 where ord_date = '2012-08-17');
 
select a.*, b.ord_no, b.ord_date, b.purch_amt
from customer a inner join orders b
on a.customer_id = b.customer_id and b.ord_date='2012-08-17';
 
#11
select name, salesman_id
from salesman
where salesman_id in 
(select salesman_id
 from customer
 group by salesman_id
 having count(customer_id) > 1);

select a.name, a.salesman_id
from salesman a inner join 
(select salesman_id
 from customer
 group by salesman_id
 having count(customer_id) > 1) b
on a.salesman_id = b.salesman_id;

SELECT salesman_id, name 
FROM salesman a 
WHERE 1 < 
(SELECT COUNT(*) 
 FROM customer b 
 WHERE b.salesman_id=a.salesman_id);

#12
select a.*
from orders a inner join 
(select customer_id, avg(purch_amt) as avg_amt
 from orders
 group by customer_id) b
on a.customer_id = b.customer_id
where purch_amt > avg_amt;

SELECT * 
FROM orders a
WHERE purch_amt >
(SELECT AVG(purch_amt) FROM orders b 
 WHERE b.customer_id = a.customer_id);

#13
select a.*
from orders a inner join 
(select customer_id, avg(purch_amt) as avg_amt
 from orders
 group by customer_id) b
on a.customer_id = b.customer_id
where purch_amt >= avg_amt;

select * 
from orders a
where purch_amt >=
(select avg(purch_amt)
 from orders b
 where b.customer_id = a.customer_id);

#14
select sum(purch_amt), ord_date
from orders
group by ord_date
having sum(purch_amt) > max(purch_amt) +1000;

#15
select * 
from customer
where exists 
(select * 
 from customer
 where city = 'London');

#16
select *
from salesman
where salesman_id in 
(select salesman_id
 from customer
 group by salesman_id
 having count(customer_id) > 1);

select *
from salesman a
where 1 < 
(select count(customer_id)
 from customer b
 where b.salesman_id = a.salesman_id);

#17
select *
from salesman
where salesman_id in 
(select salesman_id
 from customer
 group by salesman_id
 having count(customer_id) = 1);

select *
from salesman a
where 1 = 
(select count(customer_id)
 from customer b
 where b.salesman_id = a.salesman_id);

#18
select *
from salesman
where salesman_id in 
(select salesman_id
 from orders
 group by customer_id
 having count(ord_no) > 1);
 
select a.*
from salesman a inner join
(select salesman_id, count(ord_no) as count
 from orders
 group by customer_id) b
on a.salesman_id = b.salesman_id and b.count > 1;
 
#19
select *
from salesman
where city in
(select city
 from customer);
 
#20
select name, salesman_id
from salesman
where salesman_id in 
(select salesman_id
 from customer);
 
 
select version();


 