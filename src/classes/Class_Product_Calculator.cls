public class Class_Product_Calculator{
  //https://developer.salesforce.com/forums?id=906F0000000968PIAQ
  //http://sfdc2u.blogspot.in/2013/06/adding-rows-dynamically-to-page-block.html
    
   public List<multiRowProduct> ProductsData { get; set; }
      
   public Class_Product_Calculator()
   {
       LoadData();
   }

        private void LoadData() 
        {
        ProductsData = new List<multiRowProduct>();
         
         for (List<Product2> pitem : [SELECT Name FROM Product2 limit 1]) 
            {
                for (Product2 p : pitem) 
                    {
                        
                     multiRowProduct mp = new multiRowProduct();
                     mp.getquantity();
                     mp.getamount();
                     mp.gettotal();
                     mp.getProductItems();
                     ProductsData.add(mp);
                    }
            }
        }
    
    
        private class multiRowProduct 
        {
             public Integer quantity;
             public Integer amount;
             public Integer total;
          
            
         
                
         public Integer getquantity()
         {
              return quantity;
         }

        public void setquantity(Integer quan)
        {
        quantity = quan;
        }
      
        public integer getamount()
        {
        return amount;
        }

        public void setamount(Integer amt)
        {
        amount = amt;
        }
            
       public integer gettotal()
       {
         return total;
       }

      public void settotal(Integer tol)
       {
         total = tol;
       }         
    
             public List<SelectOption> getProductItems() 
              {
                    List<SelectOption> options = new List<SelectOption>();
                    options.add(new SelectOption('Product1','Product1'));
                    options.add(new SelectOption('Product2','Product2'));
                    options.add(new SelectOption('Product3','Product3'));
                    options.add(new SelectOption('Product4','Product4'));   
                    return options;
              }  
            
      Public void calculateTotal()
      {
          
        total =  quantity *  amount ;
        
      }
}
    
    
// Add new Row
    
    public void getMyDataTable()
    {
         ProductsData.add(new multiRowProduct());
    }
    
     public void removeMyDataTable()
    {
         ProductsData.clear();
    }
    
  
}