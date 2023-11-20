
with top_industry as
(Select
 i.industry as industry,

   count(i.*) as num


from industries as i
inner join dates as d
on i.company_id = d.company_id

Where extract(year from d.date_joined) IN ('2019', '2020', '2021')

group by i.industry
order by count(i.*) desc
 limit 3

),

 billions as
(select i.industry as industry,
extract(year from d.date_joined) as year,
count(i.*) as num_unicorns,

avg(f.valuation) as average_valuation

from industries as i
 inner join dates as d
 on i.company_id = d.company_id
inner join funding as f
 on d.company_id = f.company_id

group by i.industry, year

)


select 
industry,
year,
num_unicorns,
round(avg(average_valuation/1000000000), 2) as average_valuation_billions


from billions

where year in ('2019', '2020', '2021')

and industry in (select industry
				from top_industry)
	group by industry, num_unicorns, year
	order by year desc, num_unicorns desc







