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
    
    public partial class Production
    {
        public int Id { get; set; }
        public int IdChicken { get; set; }
        public System.DateTime Data { get; set; }
        public int NumberOfEggs { get; set; }
    
        public virtual Chickens Chickens { get; set; }
    }
}
