module com.example.trojkatpascal_lab_zad2 {
    requires javafx.controls;
    requires javafx.fxml;

    requires org.controlsfx.controls;
    requires org.kordamp.ikonli.javafx;
    requires org.kordamp.bootstrapfx.core;

    opens com.example.trojkatpascal_lab_zad2 to javafx.fxml;
    exports com.example.trojkatpascal_lab_zad2;
}