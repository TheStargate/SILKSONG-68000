package converter;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;

public class ImageConverter {

  public static void main(String[] args) {
    ImageConverter i = new ImageConverter();
    i.loadImage();
  }

  void loadImage() {
    try {

      BufferedImage image = ImageIO.read(new File("enemy.jpg"));
      if (image != null) {
        System.out.println("Imagen cargada exitosamente");
        conversion(image);
      } else {
        System.out.println("No se pudo cargar la imagen");
      }
    } catch (IOException ex) {
      System.err.println(ex.getMessage());
    }
  }

  void conversion(BufferedImage image) {
    byte height = (byte) image.getHeight();
    byte width = (byte) image.getWidth();
    byte[] pixeles = new byte[((height * width) * 4) + 2];

    int red;
    int green;
    int blue;

    int rgb;
    pixeles[0] = height;
    pixeles[1] = width;
    int index = 2;
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        rgb = image.getRGB(i, j); //Obtenemos el color de cada pixel
        red = (rgb >> 16) & 0xFF;   // Canal rojo
        green = (rgb >> 8) & 0xFF;  // Canal verde
        blue = rgb & 0xFF;          // Canal azul
        //Recordar que en Easy68k utilizamos BGR
        pixeles[index++] = 0;
        pixeles[index++] = (byte) blue;
        pixeles[index++] = (byte) green;
        pixeles[index++] = (byte) red;
        
      }
    }
    export(pixeles);
  }

  void export(byte[] pixeles) {
    try {
      FileOutputStream fos = new FileOutputStream(new File("src/../../enemy.bin"));
      fos.write(pixeles);
    } catch (IOException ex) {
      System.err.println(ex.getMessage());
    }
  }
}
