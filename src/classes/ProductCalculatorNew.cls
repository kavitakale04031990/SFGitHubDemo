public class ProductCalculatorNew {
    Integer qty; Integer price; Integer total;
    
    public void calculateTotal()
    {
        system.debug('function called');
        total = qty * price;
        // ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Invalid Input.');
        //    ApexPages.addMessage(myMsg);
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

    String ProductType;
    List<Product2> products;
    
    public List<Product2> getProducts() {
        if(products == null)
            products = [select id, name from Product2 Limit 1];
        return products;
    }

}