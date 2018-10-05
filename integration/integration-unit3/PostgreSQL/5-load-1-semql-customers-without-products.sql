/* SemQL expression to search for customers who don't have any products.
 * Run in the Customer Business View using the SemQL filter type.
 */
PersonType = 'CUSTOMER' AND NOT ANY PersonProducts HAVE ( ID is not null )
