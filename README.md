### README.md
#### Author: Brittany Antonczak<br/>Last Updated: 2023-05-19

<br/> 

---

## **generate.schema.ini**
#### *Function to Generate Schema.ini File for ArcGIS*

---

<br/> 

generate.schema.ini is a function to generate a schema information file (schema.ini) for a text data source. Prior to executing the function, the text data source must be imported into R as a data object. This function is limited to certain data types: Text, Long, and Double.

Schema.ini files help ensure that ArcGIS handles the information in the delimited text files correctly (e.g., ensure the correct interpretation of field types). Schema.ini files are particularly important for data with fields containing leading zeros (e.g., GEOIDs).

The schema information file should always named Schema.ini and should always stored in the same directory as the text data source. 

<br/> 

### **Usage**

```{}
generate.schema.ini(data, file_name, out_dir)
```
  
<br/> 

### **Arguments**

**data** - Data object of text data source to be referenced in schema information file.<br/> 
**file_name** - (character) File name with file extension (e.g., .csv) of text data source.<br/> 
**out_dir** - (character) Directory path to store the output schema information file. This should be the folder as the text data source.<br/> 

<br/> 

### **Example**

See supplementary R file for an example of how to use the   generate.schema.ini function:

*generate_schema_example.R*

<br/> 

