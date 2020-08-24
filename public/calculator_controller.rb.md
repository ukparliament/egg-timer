# Calculator controller to build the form and run the calculations.

Individual calculations for different flavours of instrument are packaged into separate files. This code requires those files to be loaded.

## The controller itself.

Include code from each of the modules for the different styles of calculation.

### This is the code to provide information for the form that users can fill in.

Set a title for the page.

Find all the active procedures in display order - to populate the procedure radio buttons on the form.

### When the user has pressed 'Calculate', this code runs the calculation.

Set a title for the page.

In order to calculate the scrutiny period, we need:

* the **type of the procedure** itself, which we refer to by a number

* the **start date**, for example: "2020-05-06"

* the **day count**

Check that all the parameters have been provided by the form ...

... if not, set an error message ...

... and display the error.

If the form did provide all the required information, do the calculation:

* find the procedure

* the **number of days** to count

* make the text of the date passed into a date format

To calculate the **anticipated end date**, we select the calculation based on the type of procedure:

* Legislative Reform Orders, Localism Orders and Public Bodies Orders

* Proposed Statutory Instrument (PNSI)

* Commons only negative Statutory Instrument and some made affirmatives

* Commons and Lords negative Statutory Instrument or a Commons and Lords affirmative Statutory Instrument where either House is sitting

* Commons and Lords affirmative Statutory Instrument where both Houses are sitting

* Treaty period A

* Treaty period B

* Otherwise set an error message.

