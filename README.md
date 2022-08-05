
## JSP Tags Overview

There are two categories of JSP tags.  
<img src="img_11.png" alt="drawing" width="500"/>
**JSP Custom Tags** : Where we can write your own code and implement that code and use it as a tag .

**JSP Standard Tag Library (JSTL)** : Created by Oracle, common set of tags that can be used in JSP environment.

**Problem**
+ Email from: The Boss

<img src="img_10.png" width="500" />  

**Option 1 : Use Scriptlets**
```JSP
<%
  // connect to remote weather service

  // submit our weather request

  // receive weather results

  // parse the data: xml or json ?? 

  // display outout in JSP page
%>
```

> **Bad Practice**
>> + Mix business code with presentation code
>> + Not reusable

**Option 2: JSP Custom Tags**
+ Move heavy business logic into supporting class
+ Insert JSP custom tag to use supporting class

<img src="img_9.png" width="500"/>

As an example we can drop custom tag called weather report and add real heavy lifting is implement by a supporting by back-end java class   
<img src="img_7.png" width="200"/>
<img src="img_8.png" width="200"/>
**Benefits of JSP Custom Tags**
+ Minimize the amount of scriptlet code in a JSP
+ Avoids dumping thousands of line of code in a JSP
+ JSP page is simple ... main foucs of JSP in only the presentation
+ Tag is reusable

**JSP Standard Tad Library (JSTL)**

Oracle created a Specification for standard tags
+ Core
+ Messages Formating L18N
+ Functions
+ XML
+ SQL

_Core:_ For handling variables and looping and conditionals.
_Messages Formating L18N:_ For handling internationalization and formating.
_Functions:_ For doing string manipulation, getting the sizes of a collection.
_XML:_ For parsing and setting XML data.
_SQL:_ For accessing a database.

> SQL tags in general are considered bad practice.
> > Are good for prototyping, but not for real-world production applications.
> >


### JSTL Core Tags

| Tag       | Description                                                                            |
| --------- | -------------------------------------------------------------------------------------- |
| catch     | catches any throwable to occurs in the body                                            |
| choose    | Conditional tag that can be used for exclusive operations, similar to switch statement |
| if        | simple if/then conditional                                                             |
| import    | retrieves a URL and exposes its contents on the page or a variable                     |
| forEach   | Iterates over a collection of values                                                   |
| forTokens | Iterates over a collection of tokens                                                   |
| out       | Used in scriptlets to display output, similar to <%= ... %>                            |
| otherwise | Used with the `<choose>` tag to handle the else clause                                 |
| param     | Adds a parameter to a URL                                                              |
| redirect  | Redirects the browser to a new URL                                                     |
| remove    | Removes a scoped variable                                                              |
| set       | Assigns an expression value to a variable                                              |
| url       | Defines a URL with query parameters                                                    |
| when      | Used with the `<choose>` tag when a condition is true                                  |


**JSP Core Taglib Reference**
+ Every page that uses the Core tags must include this reference:
  ![img_6.png](img_6.png)

It's simply a unique identifier that associates your tag in the jar file.

#### foreach Tag

**Example: Looping with `forEach` Tag**   
![img_5.png](img_5.png)
+ At the top we have sample data, this is a part of a scriptlet
> Use JSTL to minimize scriptlets here just to load some sample data.
> > In the real world this will be provided by MVC system.

+ `cites` are set up as an attribute, whenever use of JSTL tags, they have to be a part of an attribute as on of the scope either `request`, `session` or `application`.
    + Here `pageContext.setAttribute(name , value)` reference to the object value is String[] cities.

  
![img_4.png](img_4.png)

**Example with forEach - Build HTML Tables**

<img src="https://user-images.githubusercontent.com/80107049/182731397-83eb4206-4462-4732-b968-6bad9d347bfc.png" width="500"/>  


```JSP
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.*, com.tilmeez.tagdemo.Student" %>

<%
    // just create some sample ta ... normally provided by MVC
    List<Student> data = new ArrayList<>();

    data.add(new Student("John", "Doe", false));
    data.add(new Student("Maxwell", "Johson", false));
    data.add(new Student("Mary", "Public", true));

    pageContext.setAttribute("myStudent", data);
%>
<html>
<body>
    <table border="1">

        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Gold Customer</th>
        </tr>

        <c:forEach var="tempStudent" items="${myStudent}">
            <tr>
                <td>${tempStudent.firstName}</td>
                <td>${tempStudent.lastName}</td>
                <td>${tempStudent.goldCustomer}</td>
            </tr>
        </c:forEach>

    </table>

</body>
</html>
```

**Question:**

Is it possible to read cookie without scriptlet but using JSTL code?

**Answer:**   
Yes. The standard syntax to access HTTP Cookie value in JSP is:

```JSP
${cookie.<cookie name>.value}
```

So if you want to print value of cookie named “foobar” on JSP page, you would use:

```JSP
${cookie.foobar.value}
```

You can also loop through all of the cookies using this

```JSP
<c:forEach items="${cookie}" var="currentCookie">  
    Cookie name as map entry key: ${currentCookie.key} <br/>
    Cookie object as map entry value: ${currentCookie.value} <br/>
    Name property of Cookie object: ${currentCookie.value.name} <br/>
    Value property of Cookie object: ${currentCookie.value.value} <br/>
</c:forEach>
```


#### if tag

**Conditional Tests**

The `<c:if>` tag evaluates an expression and displays its body content only if the expression evaluates to true.

**Code Example**
* Display **Special Discount** if student is a gold customer  
  <img src="img_2.png" width="500"/>
```JSP
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.*, com.tilmeez.tagdemo.Student" %>

<%
    // just create some sample ta ... normally provided by MVC
    List<Student> data = new ArrayList<>();

    data.add(new Student("John", "Doe", false));
    data.add(new Student("Maxwell", "Johson", false));
    data.add(new Student("Mary", "Public", true));

    pageContext.setAttribute("myStudent", data);
%>
<html>
<body>
    <table border="1">

        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Gold Customer</th>
        </tr>

        <c:forEach var="tempStudent" items="${myStudent}">
            <tr>
                <td>${tempStudent.firstName}</td>
                <td>${tempStudent.lastName}</td>
                <td>
                        <c:if test="${tempStudent.goldCustomer}">
                            Special Discount
                        </c:if>

                        <c:if test="${not tempStudent.goldCustomer}">
                            -
                        </c:if>
                </td>
            </tr>
        </c:forEach>

    </table>

</body>
</html>
```


<img src="img_1.png" width="300"/>

#### Choose tag

**Conditional Tests**

The `<c:choose>`tag is similar to a switch statement.

**Code Example**  
<img src="img_12.png" width=500/>

 ```JSP 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.*, com.tilmeez.tagdemo.Student" %>

<%
    // just create some sample ta ... normally provided by MVC
    List<Student> data = new ArrayList<>();

    data.add(new Student("John", "Doe", false));
    data.add(new Student("Maxwell", "Johson", false));
    data.add(new Student("Mary", "Public", true));

    pageContext.setAttribute("myStudent", data);
%>
<html>
<body>
    <table border="1">

        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Gold Customer</th>
        </tr>

        <c:forEach var="tempStudent" items="${myStudent}">
            <tr>
                <td>${tempStudent.firstName}</td>
                <td>${tempStudent.lastName}</td>
                <td>
                    <c:choose>

                    <c:when test="${tempStudent.goldCustomer}">
                        Special Discount
                    </c:when>

                    <c:otherwise>
                        no soup for you!
                    </c:otherwise>

                    </c:choose>
                </td>
            </tr>
        </c:forEach>

    </table>

</body>
</html>
```
<img src="img.png" width = 200/>

## JSP Standard Tag Library(JSTL)-Function Tags


**JSTL Functions - Prefix "fn"**

+ **Collection Length**
  + Length
+ **String manipulation**
  + toUpperCase, toLowerCase
  + substring, substringAfter, substringBefore
  + trim, replace, indexOf, startsWith, endsWith
  + contains, containsIgnoreCase, split, join ,excapeXml

**JSTL Functions Reference**
+ Every page uses the Function tags must include this reference:

![img_17.png](img_17.png)
**Code Example**

```JSP
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<body>

<c:set var="data" value="tilmeez" />

Length of the string <b>${data}</b>: ${fn:length(data)}

<br/><br/>

Uppercase version of the string <b>${data}</b>: ${fn:toUpperCase(data)}

<br/><br/>

Does the string <b> start with </b> <b>t</b>?: ${fn:startsWith(data, "t")}
</body>

</html>
```


<img src="img_16.png" width = 300 />   





**JSTL Split Function**

The `fn:split()` function splits a String into an array of substrings based on delimiter.

```JSP
  String[] split(String data, String delimiter)
```

**Code Example**   
<img src="img_15.png" width = 600 />




**JSTL Join Function**

The `fn:join()` function concatenates a String array into single String based on a delimiter.

```JSP
  String join(String[] data, String delimiter)
```

**Code Example**  

<img src="img_14.png" width=600 />

```JSP 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>

<c:set var="data" value="Singapore, Karachi, London, Dusseldorf"/>

<h3>Split Demo</h3>

<c:set var="citiesArray" value="${fn:split(data, ',')}"/>

<c:forEach var="tempCity" items="${citiesArray}">
    ${tempCity} <br/>
</c:forEach>

<h3>Join Demo</h3>

<c:set var="fun" value="${fn:join(citiesArray, '*')}"/>

Result of joining: ${fun}
</body>
</html>
```

<img src="img_13.png" width = 300 />