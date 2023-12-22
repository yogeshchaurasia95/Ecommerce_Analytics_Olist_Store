#1 Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics

select 
case
when weekday(order_purchase_timestamp) = 5 then 'WeekEnd'
when weekday(order_purchase_timestamp) = 6 then 'WeekEnd'
else 'Weekday' 
end as Weekday_Weekend,
round(sum(payment_value)) as payment
from
olist_orders_dataset as orders join olist_order_payments_dataset as payment
on orders.order_id = payment.order_id
group by Weekday_Weekend;


#2 Number of Orders with review score 5 and payment type as credit card.

select 
payment.payment_type,
review.review_score,
count(distinct review.order_id)
from
olist_order_reviews_dataset as review join olist_order_payments_dataset as payment
on review.order_id = payment.order_id
where review.review_score in (5) and payment.payment_type in ('credit_card');


#3 Average number of days taken for order_delivered_customer_date for pet_shop

select
round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp))) as shipping_days,
product_category_name
from
olist_order_dataset as orders join olist_order_items_dataset as items
on orders.order_id = items.order_id
join olist_products_dataset as product
on items.product_id = product.product_id
where product_category_name = ('pet_shop');


#4 Average price and payment values from customers of sao paulo city

select
customer.customer_city,
round(avg(price)) as Average_price,
round(avg(payment_value)) as Average_payment
from olist_customers_dataset as customer join olist_order_dataset as orders 
on customer.customer_id =orders.customer_id
join olist_order_items_dataset as items
on orders.order_id=items.order_id
join olist_order_payments_dataset as payment
on payment.order_id= orders.order_id
where customer.customer_city = ('sao paulo');


#5 Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.

select
review_score,
round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp))) as shipping_days
from olist_order_dataset as orders join olist_order_reviews_dataset as reviews
on orders.order_id = reviews.order_id
group by review_score
order by review_score;


#6 Top 5 customer cities based on payment values

select 
customer_city,
round(sum(payment_value))as payment
from 
olist_customers_dataset as customer join olist_order_dataset as orders
on customer.customer_id = orders.customer_id
join olist_order_payments_dataset as payment
on orders.order_id =payment.order_id
group by customer_city
order by sum(payment_value) desc
limit 5;







