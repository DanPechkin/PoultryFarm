//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Poultry_farm
{
    using System;
    using System.Collections.Generic;
    
    public partial class Workshop
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Workshop()
        {
            this.Cages = new HashSet<Cages>();
            this.Workers = new HashSet<Workers>();
        }
    
        public int Id { get; set; }
        public string ShopName { get; set; }
        public int NumberOfRows { get; set; }
        public int NumberOfCages { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Cages> Cages { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Workers> Workers { get; set; }
    }
}
