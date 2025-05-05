import cv2
import numpy as np




def convert_rgb_to_YCbCr(image):
    a = 0

    R = image[:, :, 0].astype(np.float32)
    G = image[:, :, 1].astype(np.float32)
    B = image[:, :, 2].astype(np.float32)

    Y = 0.299 * R + 0.587 * G + 0.144 * B
    Cb = (-0.168736 * R - 0.331264 * G + 0.5 * B) + 128
    Cr = (0.5 * R - 0.418688 * G - 0.081312 * B) + 128

    ycbr_image = np.stack([Y, Cb, Cr], axis=-1).astype(np.uint8)

    return ycbr_image


def binaryzation(image,mask,Ta,Tb,Tc,Td):
    Cb = image[:,:,1]
    Cr = image[:,:,2]

    for n in range(len(Cb)):
        for m in range(len(Cb[0])):
            
            if Cb[n][m] > Ta and Cb[n][m] < Tb and Cr[n][m] > Tc and Cr[n][m] < Td:

                mask[n][m] = 255
            else:
                mask[n][m] = 0

    return mask        

def main():

    Ta = 100
    Tb = 133
    Tc = 135
    Td = 165

    image = cv2.imread("./hand.jpg")[:, :, ::-1]
    # cv2.imshow("Imagade ycbr",image)
    # cv2.waitKey(0)

    img_scl = cv2.resize(image, (64, 64), interpolation=cv2.INTER_LINEAR)

    cv2.imwrite("./handppm.ppm",img_scl)

    ycbr_image = convert_rgb_to_YCbCr(image)

    ycbr_image = cv2.resize(ycbr_image, (64, 64), interpolation=cv2.INTER_LINEAR)

    cv2.imwrite("./scaled_ycbcr_hand.jpg",ycbr_image)
    cv2.imwrite("./scaled_ycbcr_hand.ppm",ycbr_image)

    height = ycbr_image.shape[0]
    width = ycbr_image.shape[1]

    mask = np.zeros((height, width), dtype=np.uint8)

    mask = binaryzation(ycbr_image,mask,Ta,Tb,Tc,Td)

    # cv2.imshow("Imagade ycbr",mask)
    # cv2.waitKey(0)
    cv2.imwrite("./mask_hand.jpg",mask)
    # cv2.imwrite("./mask_hand.ppm",mask)

    filtered_mask = cv2.medianBlur(mask,5)

    cv2.imwrite("./filtered_mask_hand.jpg",filtered_mask)
    # cv2.imwrite("./filtered_mask_hand.ppm",filtered_mask)
    
    moments = cv2.moments(filtered_mask)
    
    if moments["m00"] != 0:  # Żeby uniknąć dzielenia przez zero
        cx = int(moments["m10"] / moments["m00"])  # Środek ciężkości X
        cy = int(moments["m01"] / moments["m00"])  # Środek ciężkości Y

    
    cv2.line(filtered_mask, (cx, 0), (cx, 64), (0, 255, 0))
    cv2.line(filtered_mask, (0, cy), (64, cy), (0, 255, 0))         
    
    # cv2.imshow("Imagade ycbr",filtered_mask)
    # cv2.waitKey(0)

    cv2.imwrite("./filtered_mask_center_graf_hand.jpg",filtered_mask)
    # cv2.imwrite("./filtered_mask_center_graf_hand.ppm",filtered_mask)

    a = 0
main()