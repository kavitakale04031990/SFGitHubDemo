//https://developer.salesforce.com/forums?id=906F0000000968PIAQ
  //http://sfdc2u.blogspot.in/2013/06/adding-rows-dynamically-to-page-block.html

public class ProductCalculator {

    public void addRow() {
        productData.add(new multiRowProduct());
    }
    
  /*   public void removeRow() {
        productData.clear();
    }  */

    
    public List<multiRowProduct> productData { get; set; }
    
    public ProductCalculator()
    {
        loadData();
    }
    
    public void loadData()
    {   
        productData = new List<multiRowProduct>();
        
        for (List<Product2> p : [select id, name from Product2 Limit 1])
        {
            for (Product2 prows : p)
            {
                 multiRowProduct mp = new multiRowProduct();
                 mp.getQuantity();
                 mp.getProdPrice();
                 mp.getProdTotal();
                 mp.getItems();               
                 productData.add(mp);
                
            }
        }
     }    
    
    public class multiRowProduct 
    {   
        Integer qty; Integer price; Integer total;
        
       public PageReference calculateTotal() {
            system.debug('calculate total called' );   
            calcTotal();
            return null;
        }   
       
        public Integer calcTotal()
        {
            total = qty * price;
            system.debug('total is: ' + total);
            return total;
        }
       
        public Integer getQuantity() {
            return qty;
        }
        
        public void setQuantity(Integer q) {
           qty = q;
        }
        
         public Integer getProdPrice() {
            return price;
        }
        
        public void setProdPrice(Integer p)
        {
            price = p;
        }
        
         public Integer getProdTotal() {
            return total;
        }
        
        public void setProdTotal(Integer t)
        {
            total = t;
        }
        
        public List<SelectOption> getItems() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('Product1','Product 1'));
            options.add(new SelectOption('Product2','Product 2'));
            options.add(new SelectOption('Product3','Product 3'));
            return options;
        }
    
       
        public String prod {get; set;}  
    }
}